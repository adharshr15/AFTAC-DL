import numpy as np
import pandas as pd
from datetime import datetime, timedelta

# Paths to your files
X_PATH = "./public/assets/X_test_feature_0.npy"
Y_PATH = "./public/assets/Y_test_feature_0.npy"
OUTPUT_CSV = "synthetic_data_from_npy.csv"

# Standard scaler parameters
temp_mean = 40.00946858359476
temp_std = 4.8101438894455

# Load X and Y numpy arrays
X = np.load(X_PATH)  # shape: (num_samples, 48, 1)
Y = np.load(Y_PATH)  # shape: (num_samples,)

num_samples = Y.shape[0]

rows = []
start_time = datetime(2025, 1, 1, 0, 0, 0)

for i in range(num_samples):
    # Unnormalize Y value
    Y_value = Y[i] * temp_std + temp_mean

    # Get the corresponding sequence from X, unnormalize
    sequence = X[i].flatten() * temp_std + temp_mean
    sequence_list = sequence.tolist()  # Convert to a list for CSV

    timestamp = start_time + timedelta(hours=i)
    row = {
        "machine_id": 1,
        "timestamp": timestamp.strftime("%Y-%m-%d %H:%M:%S"),
        "T_internal_sensor": Y_value,
        "V_sensor": 15.0,  # placeholder
        "failure_mode": 1,
        "is_precursor_period": 0,
        "is_final_failure": 0,
        "T_internal_sequence": sequence_list  # new column
    }
    rows.append(row)

# Convert to DataFrame and save
df = pd.DataFrame(rows)
df.to_csv(OUTPUT_CSV, index=False)

print(f"CSV with sequences saved to {OUTPUT_CSV}")