import argparse
import sys
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score

import torch
import torch.nn as nn
from torch.utils.data import Dataset, DataLoader

import matplotlib
# Use a non-interactive backend to avoid Qt/xcb platform plugin issues on headless systems
matplotlib.use('Agg')
import matplotlib.pyplot as plt

try:
    import optuna
except Exception:
    optuna = None

# Config
DATA_FILES = ["./data/synthetic_data_independent_failures_5.csv", "./data/synthetic_data_independent_failures_4.csv"]

SEQUENCE_LENGTH = 24 * 7
STEP_SIZE = 24 * 2
FORECAST_HORIZON = 1
BATCH_SIZE = 32
NUM_EPOCHS = 10

DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")


def load_and_combine_data(file_paths):
    """
    Loads multiple CSV files, finds the union of all sensor features,
    reindexes dataframes to match the full feature set (filling missing sensors with 0.0),
    and concatenates them into a single DataFrame.
    Returns (combined_df, sensor_feature_list)
    """
    all_data = []
    all_sensor_features = set()
    non_sensor_cols = ['machine_id', 'timestamp', 'failure_mode', 'is_precursor_period', 'is_final_failure']

    for file_path in file_paths:
        try:
            df = pd.read_csv(file_path)
            current_sensor_features = [col for col in df.columns if col not in non_sensor_cols]
            print(f"Found sensor features in {file_path}: {current_sensor_features}")
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


def prepare_data(df, sensor_features, seq_length=SEQUENCE_LENGTH, step_size=STEP_SIZE):
    """Loads, scales and creates sequences from the dataframe.

    Args:
        df: pandas DataFrame
        sensor_features: list of sensor column names
        seq_length: sequence length (time steps)
        step_size: sliding window step size
    """
    sensor_data = df[sensor_features].values
    scaler = StandardScaler()
    sensor_data_scaled = scaler.fit_transform(sensor_data)
    X_seq, Y_seq = create_sequences(sensor_data_scaled, seq_length, FORECAST_HORIZON, step_size)
    print(f"\n--- Data Preparation Complete ---")
    print(f"Total time points in raw data: {len(df)}")
    print(f"Total sequences created: {len(X_seq)}")
    print(f"Sequence shape (num_samples, time steps, features): {X_seq.shape}")
    return X_seq, Y_seq, scaler


class TimeDataset(Dataset):
    """Custom PyTorch Dataset for time-series sequences."""
    def __init__(self, X_data, y_data, feature_idx):
        # keep one feature channel for CNN: shape -> (N, 1, seq_length)
        self.X_data = torch.tensor(X_data[:, :, feature_idx: feature_idx + 1], dtype=torch.float32).permute(0, 2, 1)
        # targets: shape (N, forecast_horizon)
        self.y_data = torch.tensor(y_data[:, :, feature_idx: feature_idx + 1], dtype=torch.float32).squeeze(-1)

    def __len__(self):
        return len(self.y_data)

    def __getitem__(self, idx):
        return self.X_data[idx], self.y_data[idx]


class CNNClassifier(nn.Module):
    """
    Simple 1D CNN for time-series regression built with PyTorch.
    """
    def __init__(self, seq_length, forecast_horizon):
        super(CNNClassifier, self).__init__()
        self.conv1 = nn.Conv1d(in_channels=1, out_channels=64, kernel_size=3, padding=0)
        self.pool = nn.MaxPool1d(kernel_size=2)
        conv_output_size = (seq_length - 2) // 2
        flattened_size = 64 * conv_output_size
        self.fc1 = nn.Linear(flattened_size, 100)
        self.fc2 = nn.Linear(100, forecast_horizon)

    def forward(self, x):
        x = torch.relu(self.conv1(x))
        x = self.pool(x)
        x = x.view(x.size(0), -1)
        x = torch.relu(self.fc1(x))
        x = self.fc2(x)
        return x


def train_model(model, train_loader, val_loader, criterion, optimizer, num_epochs):
    print(f"\n--- Starting PyTorch Model Training ({num_epochs} Epochs) ---")
    train_losses = []
    val_losses = []
    for epoch in range(num_epochs):
        model.train()
        train_loss = 0.0
        train_batches = 0
        for inputs, targets in train_loader:
            inputs, targets = inputs.to(DEVICE), targets.to(DEVICE)
            outputs = model(inputs)
            loss = criterion(outputs, targets)
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()
            train_loss += loss.item()
            train_batches += 1
        avg_train_loss = train_loss / max(1, train_batches)
        train_losses.append(avg_train_loss)

        model.eval()
        val_loss = 0.0
        val_batches = 0
        with torch.no_grad():
            for inputs, targets in val_loader:
                inputs, targets = inputs.to(DEVICE), targets.to(DEVICE)
                outputs = model(inputs)
                loss = criterion(outputs, targets)
                val_loss += loss.item()
                val_batches += 1
        avg_val_loss = val_loss / max(1, val_batches)
        val_losses.append(avg_val_loss)
        print(f'Epoch [{epoch+1}/{num_epochs}] - Train Loss: {avg_train_loss:.4f}, Val Loss: {avg_val_loss:.4f}')
    return train_losses, val_losses


def evaluate_model(model, test_loader):
    model.eval()
    y_true = []
    y_pred = []
    with torch.no_grad():
        for inputs, targets in test_loader:
            inputs = inputs.to(DEVICE)
            targets = targets.to(DEVICE)
            outputs = model(inputs)
            y_true.extend(targets.cpu().numpy())
            y_pred.extend(outputs.cpu().numpy())
    return np.array(y_true), np.array(y_pred)


def run_experiment(seq_len, step_size, select_model, epochs, verbose=True):
    """Helper to train the CNN with given sequence and step and return validation loss."""
    # reload data so this function can be used by HPO without interfering global state
    data, sensor_features = load_and_combine_data(DATA_FILES)
    X_seq, Y_seq, _ = prepare_data(data, sensor_features, seq_length=seq_len, step_size=step_size)

    indices = np.arange(X_seq.shape[0])
    train_val_indices, test_indices = train_test_split(indices, test_size=0.2, random_state=42, shuffle=False)
    train_indices, val_indices = train_test_split(train_val_indices, test_size=0.25, random_state=42, shuffle=False)

    X_train, X_val = X_seq[train_indices], X_seq[val_indices]
    Y_train, Y_val = Y_seq[train_indices], Y_seq[val_indices]

    train_dataset = TimeDataset(X_train, Y_train, select_model)
    val_dataset = TimeDataset(X_val, Y_val, select_model)
    train_loader = DataLoader(dataset=train_dataset, batch_size=BATCH_SIZE, shuffle=True)
    val_loader = DataLoader(dataset=val_dataset, batch_size=BATCH_SIZE, shuffle=False)

    model = CNNClassifier(X_train.shape[1], FORECAST_HORIZON).to(DEVICE)
    criterion = nn.MSELoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=0.001)

    _, val_losses = train_model(model, train_loader, val_loader, criterion, optimizer, epochs)
    final_val = val_losses[-1] if len(val_losses) > 0 else float('inf')
    if verbose:
        print(f"Experiment seq_len={seq_len} step={step_size} -> val_loss={final_val:.6f}")
    return final_val


def calculate_msre(y_pred, y_true):
    avg_error_per_column = np.mean(np.abs(y_true - y_pred), axis=0)
    print(f"Average error per column: {avg_error_per_column}")
    mse = np.mean((y_true - y_pred) ** 2)
    print(f"Total MSE: {mse}")
    return np.sqrt(mse)


def main(args):
    print(f"Using device: {DEVICE}")
    try:
        data, sensor_features = load_and_combine_data(DATA_FILES)
    except FileNotFoundError as e:
        print(f"Fatal Error: {e}")
        sys.exit(1)

    # If user specified explicit seq/step, use those; otherwise defaults
    seq_len = args.sequence_length if getattr(args, 'sequence_length', None) is not None else SEQUENCE_LENGTH
    step_size = args.step_size if getattr(args, 'step_size', None) is not None else STEP_SIZE

    X_seq, Y_seq, scaler = prepare_data(data, sensor_features, seq_length=seq_len, step_size=step_size)

    indices = np.arange(X_seq.shape[0])
    train_val_indices, test_indices = train_test_split(indices, test_size=0.2, random_state=42, shuffle=False)
    train_indices, val_indices = train_test_split(train_val_indices, test_size=0.25, random_state=42, shuffle=False)

    X_train, X_val, X_test = X_seq[train_indices], X_seq[val_indices], X_seq[test_indices]
    Y_train, Y_val, Y_test = Y_seq[train_indices], Y_seq[val_indices], Y_seq[test_indices]

    print(f"\n--- Data Split ---")
    print(f"Training set: {len(X_train)} sequences ({len(X_train)/len(X_seq)*100:.1f}%)")
    print(f"Validation set: {len(X_val)} sequences ({len(X_val)/len(X_seq)*100:.1f}%)")
    print(f"Test set: {len(X_test)} sequences ({len(X_test)/len(X_seq)*100:.1f}%)")

    train_loader = []
    val_loader = []
    test_loader = []
    for i in range(X_train.shape[2]):
        train_dataset = TimeDataset(X_train, Y_train, i)
        val_dataset = TimeDataset(X_val, Y_val, i)
        test_dataset = TimeDataset(X_test, Y_test, i)
        train_loader.append(DataLoader(dataset=train_dataset, batch_size=BATCH_SIZE, shuffle=True))
        val_loader.append(DataLoader(dataset=val_dataset, batch_size=BATCH_SIZE, shuffle=False))
        test_loader.append(DataLoader(dataset=test_dataset, batch_size=BATCH_SIZE, shuffle=False))

    select_model = args.select_model
    if select_model < 0 or select_model >= len(sensor_features):
        print(f"select_model {select_model} out of range (0..{len(sensor_features)-1}). Using 0.")
        select_model = 0

    model = CNNClassifier(X_train.shape[1], FORECAST_HORIZON).to(DEVICE)
    print("\nModel Architecture:")
    print(model)

    criterion = nn.MSELoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=0.001)

    train_losses, val_losses = train_model(model, train_loader[select_model], val_loader[select_model], criterion, optimizer, NUM_EPOCHS)

    # If optimization flag supplied, we won't run the normal training/eval below here
    # (optimization flow handled separately in --optimize branch executed earlier)

    # Plot training and validation loss
    plt.figure(figsize=(10, 6))
    plt.plot(range(1, NUM_EPOCHS + 1), train_losses, label='Training Loss', marker='o')
    plt.plot(range(1, NUM_EPOCHS + 1), val_losses, label='Validation Loss', marker='s')
    plt.xlabel('Epoch')
    plt.ylabel('Loss (MSE)')
    plt.title('Training vs Validation Loss')
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig('train_val_loss.png')
    plt.close()

    print("\n--- Evaluating Model Performance ---")
    y_true, y_pred = evaluate_model(model, test_loader[select_model])
    # Regression metrics
    mse = mean_squared_error(y_true.flatten(), y_pred.flatten())
    mae = mean_absolute_error(y_true.flatten(), y_pred.flatten())
    rmse = np.sqrt(mse)
    r2 = r2_score(y_true.flatten(), y_pred.flatten())
    print("\nRegression Metrics:")
    print(f"Mean Squared Error (MSE): {mse:.4f}")
    print(f"Root Mean Squared Error (RMSE): {rmse:.4f}")
    print(f"Mean Absolute Error (MAE): {mae:.4f}")
    print(f"R² Score: {r2:.4f}")

    # Scatter and timeseries plot for a subset
    y_true_flat = np.array(y_true).reshape(-1)
    y_pred_flat = np.array(y_pred).reshape(-1)
    num_samples = min(200, len(y_true_flat))
    if num_samples == 0:
        print("No test samples available to plot.")
        return
    indices = np.random.choice(len(y_true_flat), num_samples, replace=False)
    indices = np.sort(indices)

    plt.figure(figsize=(14, 6))
    plt.subplot(1, 2, 1)
    plt.plot(indices, y_true_flat[indices], 'b-', label='Actual', alpha=0.7)
    plt.plot(indices, y_pred_flat[indices], 'r--', label='Predicted', alpha=0.7)
    plt.xlabel('Sample Index')
    plt.ylabel('Sensor Value (Scaled)')
    plt.title(f'Predictions vs Actual\n{sensor_features[select_model]}')
    plt.legend()
    plt.grid(True, alpha=0.3)

    plt.subplot(1, 2, 2)
    plt.scatter(y_true_flat, y_pred_flat, alpha=0.5)
    mn = min(y_true_flat.min(), y_pred_flat.min())
    mx = max(y_true_flat.max(), y_pred_flat.max())
    plt.plot([mn, mx], [mn, mx], 'r--', lw=2)
    plt.xlabel('Actual Values')
    plt.ylabel('Predicted Values')
    plt.title('Prediction Scatter Plot')
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig('predictions_plots.png')
    plt.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Train & evaluate a simple 1D CNN on the combined synthetic sensor data')
    parser.add_argument('--select-model', type=int, default=0, help='Index of sensor feature to train/evaluate (default=0)')
    parser.add_argument('--sequence-length', type=int, default=None, help='Override sequence length (time steps)')
    parser.add_argument('--step-size', type=int, default=None, help='Override sliding window step size')
    parser.add_argument('--optimize', action='store_true', help='Run Bayesian optimization (Optuna) for seq_len and step_size')
    parser.add_argument('--trials', type=int, default=20, help='Number of Optuna trials when --optimize is used')
    parser.add_argument('--hpo-epochs', type=int, default=5, help='Number of epochs per trial during HPO')
    args = parser.parse_args()
    # If optimize flag provided, run Bayesian optimization over seq_len and step_size
    if args.optimize:
        if optuna is None:
            print("Optuna is not installed. Install it with `pip install optuna` to run optimization.")
            sys.exit(1)

        def objective(trial):
            # sample sequence length and step size (categorical choices recommended for seq lengths)
            seq = trial.suggest_categorical('seq_len', [24, 48, 72, 168])
            step = trial.suggest_categorical('step_size', [6, 12, 24, 48])
            # run short experiment to get validation loss
            val = run_experiment(seq, step, args.select_model, epochs=args.hpo_epochs, verbose=False)
            # report to optuna
            trial.report(val, 0)
            return val

        study = optuna.create_study(direction='minimize')
        study.optimize(objective, n_trials=args.trials)
        print('\nOptimization complete. Best params:')
        print(study.best_params)
        print(f"Best value: {study.best_value}")
        # After HPO, run best config for full epochs
        best_seq = study.best_params['seq_len']
        best_step = study.best_params['step_size']
        print(f"Running final training with seq_len={best_seq}, step_size={best_step} for {NUM_EPOCHS} epochs")
        # set args for main and run final training
        args.sequence_length = best_seq
        args.step_size = best_step
        main(args)
    else:
        main(args)
