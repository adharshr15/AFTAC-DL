import argparse
import sys
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score

import torch
import torch.nn as nn
from torch.utils.data import Dataset, DataLoader

import matplotlib
# Use 'Agg' for headless environments
matplotlib.use('Agg')
import matplotlib.pyplot as plt

# Config (same default files as the CNN script)
DATA_FILES = ["./data/synthetic_data_independent_failures_5.csv", "./data/synthetic_data_independent_failures_4.csv"]

SEQUENCE_LENGTH = 24 * 14  # Increased sequence length
STEP_SIZE = 24  # Smaller step size
FORECAST_HORIZON = 1
BATCH_SIZE = 16  # Smaller batch size
NUM_EPOCHS = 10

DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")


def load_and_combine_data(file_paths):
    all_data = []
    all_sensor_features = set()
    non_sensor_cols = ['machine_id', 'timestamp', 'failure_mode', 'is_precursor_period', 'is_final_failure']

    for file_path in file_paths:
        try:
            df = pd.read_csv(file_path)
            current_sensor_features = [col for col in df.columns if col not in non_sensor_cols]
            all_sensor_features.update(current_sensor_features)
            all_data.append(df)
            print(f"Loaded {file_path} with {len(current_sensor_features)} sensor features.")
        except FileNotFoundError:
            print(f"Warning: File '{file_path}' not found. Skipping.")

    if not all_data:
        raise FileNotFoundError("No valid data files were loaded.")

    sensor_feature_list = sorted(list(all_sensor_features))
    final_combined_df = pd.DataFrame()
    full_column_list = non_sensor_cols + sensor_feature_list
    for df in all_data:
        df_reindexed = df.reindex(columns=full_column_list, fill_value=0.0)
        final_combined_df = pd.concat([final_combined_df, df_reindexed], ignore_index=True)

    print(f"\nSuccessfully combined {len(all_data)} files.")
    print(f"Total rows in combined data: {len(final_combined_df)}")
    print(f"Total unique sensor features used: {len(sensor_feature_list)}")
    return final_combined_df, sensor_feature_list


def create_sequences(data, seq_length, forecast_horizon, step_size):
    sequences = []
    target = []
    for i in range(0, len(data) - seq_length - forecast_horizon + 1, step_size):
        sequences.append(data[i:i+seq_length])
        target.append(data[i+seq_length: i+seq_length+forecast_horizon])
    return np.array(sequences), np.array(target)


def prepare_data(df, sensor_features):
    sensor_data = df[sensor_features].values
    scaler = MinMaxScaler()
    sensor_data_scaled = scaler.fit_transform(sensor_data)
    X_seq, Y_seq = create_sequences(sensor_data_scaled, SEQUENCE_LENGTH, FORECAST_HORIZON, STEP_SIZE)
    print(f"\n--- Data Preparation Complete ---")
    print(f"Total time points in raw data: {len(df)}")
    print(f"Total sequences created: {len(X_seq)}")
    print(f"Sequence shape (num_samples, time steps, features): {X_seq.shape}")
    return X_seq, Y_seq, scaler


class TimeDatasetLSTM(Dataset):
    """Dataset that returns (seq_len, 1) input for LSTM and (forecast_horizon,) target."""
    def __init__(self, X_data, y_data, feature_idx):
        # X_data: (N, seq_len, features) -> we want (N, seq_len, 1)
        self.X = torch.tensor(X_data[:, :, feature_idx:feature_idx+1], dtype=torch.float32)
        # y_data: (N, forecast_horizon, features) -> squeeze feature dimension
        self.y = torch.tensor(y_data[:, :, feature_idx:feature_idx+1], dtype=torch.float32).squeeze(-1)

    def __len__(self):
        return len(self.y)

    def __getitem__(self, idx):
        return self.X[idx], self.y[idx]


class LSTMRegressor(nn.Module):
    def __init__(self, input_size, hidden_size=128, num_layers=3, forecast_horizon=1, dropout=0.2):
        super(LSTMRegressor, self).__init__()
        self.lstm = nn.LSTM(input_size=input_size, hidden_size=hidden_size, num_layers=num_layers, batch_first=True, dropout=dropout)
        self.fc = nn.Linear(hidden_size, forecast_horizon)

    def forward(self, x):
        # x: (batch, seq_len, input_size)
        out, (hn, cn) = self.lstm(x)
        # use last time-step hidden state
        last = out[:, -1, :]
        out = self.fc(last)
        return out


def train_model(model, train_loader, val_loader, criterion, optimizer, num_epochs):
    train_losses = []
    val_losses = []
    for epoch in range(num_epochs):
        model.train()
        total_loss = 0.0
        batches = 0
        for X_batch, y_batch in train_loader:
            X_batch, y_batch = X_batch.to(DEVICE), y_batch.to(DEVICE)
            preds = model(X_batch)
            loss = criterion(preds, y_batch)
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()
            total_loss += loss.item()
            batches += 1
        avg_train = total_loss / max(1, batches)
        train_losses.append(avg_train)

        model.eval()
        total_val = 0.0
        val_batches = 0
        with torch.no_grad():
            for X_batch, y_batch in val_loader:
                X_batch, y_batch = X_batch.to(DEVICE), y_batch.to(DEVICE)
                preds = model(X_batch)
                loss = criterion(preds, y_batch)
                total_val += loss.item()
                val_batches += 1
        avg_val = total_val / max(1, val_batches)
        val_losses.append(avg_val)
        print(f"Epoch [{epoch+1}/{num_epochs}] Train Loss: {avg_train:.4f} Val Loss: {avg_val:.4f}")
    return train_losses, val_losses


def evaluate_model(model, test_loader):
    model.eval()
    y_true = []
    y_pred = []
    with torch.no_grad():
        for X_batch, y_batch in test_loader:
            X_batch = X_batch.to(DEVICE)
            preds = model(X_batch)
            y_true.extend(y_batch.cpu().numpy())
            y_pred.extend(preds.cpu().numpy())
    return np.array(y_true), np.array(y_pred)


def main(args):
    print(f"Using device: {DEVICE}")
    try:
        data, sensor_features = load_and_combine_data(DATA_FILES)
    except FileNotFoundError as e:
        print(f"Fatal Error: {e}")
        sys.exit(1)

    X_seq, Y_seq, scaler = prepare_data(data, sensor_features)

    indices = np.arange(X_seq.shape[0])
    train_val_indices, test_indices = train_test_split(indices, test_size=0.2, random_state=42, shuffle=False)
    train_indices, val_indices = train_test_split(train_val_indices, test_size=0.25, random_state=42, shuffle=False)

    X_train, X_val, X_test = X_seq[train_indices], X_seq[val_indices], X_seq[test_indices]
    Y_train, Y_val, Y_test = Y_seq[train_indices], Y_seq[val_indices], Y_seq[test_indices]

    print(f"\n--- Data Split ---")
    print(f"Training set: {len(X_train)} sequences ({len(X_train)/len(X_seq)*100:.1f}%)")

    # Build dataloaders per feature (like the CNN script)
    train_loaders = []
    val_loaders = []
    test_loaders = []
    for i in range(X_train.shape[2]):
        train_ds = TimeDatasetLSTM(X_train, Y_train, i)
        val_ds = TimeDatasetLSTM(X_val, Y_val, i)
        test_ds = TimeDatasetLSTM(X_test, Y_test, i)
        train_loaders.append(DataLoader(train_ds, batch_size=BATCH_SIZE, shuffle=True))
        val_loaders.append(DataLoader(val_ds, batch_size=BATCH_SIZE, shuffle=False))
        test_loaders.append(DataLoader(test_ds, batch_size=BATCH_SIZE, shuffle=False))

    select_model = args.select_model
    if select_model < 0 or select_model >= len(sensor_features):
        print(f"select_model {select_model} out of range (0..{len(sensor_features)-1}). Using 0.")
        select_model = 0

    model = LSTMRegressor(input_size=1, hidden_size=128, num_layers=3, forecast_horizon=FORECAST_HORIZON).to(DEVICE)
    print('\nModel:')
    print(model)

    criterion = nn.MSELoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=0.001)

    train_losses, val_losses = train_model(model, train_loaders[select_model], val_loaders[select_model], criterion, optimizer, NUM_EPOCHS)

    # save training plot
    plt.figure(figsize=(8, 5))
    plt.plot(range(1, NUM_EPOCHS + 1), train_losses, label='Train')
    plt.plot(range(1, NUM_EPOCHS + 1), val_losses, label='Val')
    plt.xlabel('Epoch')
    plt.ylabel('Loss')
    plt.title('LSTM Train vs Val Loss')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.savefig('lstm_train_val_loss.png')
    plt.close()

    y_true, y_pred = evaluate_model(model, test_loaders[select_model])

    mse = mean_squared_error(y_true.flatten(), y_pred.flatten())
    mae = mean_absolute_error(y_true.flatten(), y_pred.flatten())
    rmse = np.sqrt(mse)
    r2 = r2_score(y_true.flatten(), y_pred.flatten())
    print('\nRegression Metrics:')
    print(f"MSE: {mse:.4f}, RMSE: {rmse:.4f}, MAE: {mae:.4f}, R2: {r2:.4f}")

    # Plot predictions vs actual (subset)
    y_true_flat = np.array(y_true).reshape(-1)
    y_pred_flat = np.array(y_pred).reshape(-1)
    num_samples = min(200, len(y_true_flat))
    if num_samples == 0:
        print('No test samples available to plot.')
        return
    idxs = np.random.choice(len(y_true_flat), num_samples, replace=False)
    idxs = np.sort(idxs)

    plt.figure(figsize=(14, 6))
    plt.subplot(1, 2, 1)
    plt.plot(idxs, y_true_flat[idxs], label='Actual')
    plt.plot(idxs, y_pred_flat[idxs], label='Predicted')
    plt.title(f'Predictions vs Actual\n{sensor_features[select_model]}')
    plt.legend()
    plt.grid(True)

    plt.subplot(1, 2, 2)
    plt.scatter(y_true_flat, y_pred_flat, alpha=0.5)
    mn = min(y_true_flat.min(), y_pred_flat.min())
    mx = max(y_true_flat.max(), y_pred_flat.max())
    plt.plot([mn, mx], [mn, mx], 'r--')
    plt.title('Prediction Scatter')
    plt.tight_layout()
    plt.savefig('lstm_predictions_plots.png')
    plt.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Train & evaluate an LSTM on combined synthetic sensor data')
    parser.add_argument('--select-model', type=int, default=0, help='Index of sensor feature to train/evaluate (default=0)')
    args = parser.parse_args()
    main(args)
