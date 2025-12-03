import onnxruntime as ort
import numpy as np
import pandas as pd

# ---------------------------------------------------------
# Configuration
# ---------------------------------------------------------

CSV_PATH = r"C:\Users\aprau\AFTAC-DL\dashboard\public\assets\synthetic_data_independent_failures_4_gb_timestamp.csv"
ONNX_PATH = r"C:\Users\aprau\AFTAC-DL\dashboard\public\assets\pruned_quantized_model.onnx"

SEQ_LEN = 48
TEMP_MEAN = 40.00946858359476
TEMP_STD = 4.8101438894455

TARGET_MACHINE_ID = 1  # choose any machine ID that exists
TARGET_COLUMN = "T_internal_sensor"

# ---------------------------------------------------------
# Load CSV
# ---------------------------------------------------------
print("Loading dataset...")

df = pd.read_csv(CSV_PATH)
df = df[df["machine_id"] == TARGET_MACHINE_ID].reset_index(drop=True)

temps = df[TARGET_COLUMN].values.astype(np.float32)

# ---------------------------------------------------------
# Load ONNX Model
# ---------------------------------------------------------
print("Loading ONNX model...")

session = ort.InferenceSession(
    ONNX_PATH,
    providers=["CPUExecutionProvider"]
)

input_name = session.get_inputs()[0].name
output_name = session.get_outputs()[0].name

print("Model Input:", input_name)
print("Model Output:", output_name)

# ---------------------------------------------------------
# Build sliding windows (48 → predict next)
# ---------------------------------------------------------
X = []
y = []

for i in range(len(temps) - SEQ_LEN):
    window = temps[i : i + SEQ_LEN]
    next_val = temps[i + SEQ_LEN]

    X.append(window)
    y.append(next_val)

X = np.array(X, dtype=np.float32)
y = np.array(y, dtype=np.float32)

# Scale inputs
X_scaled = (X - TEMP_MEAN) / TEMP_STD

# ---------------------------------------------------------
# Run inference
# ---------------------------------------------------------
predictions = []

print("Running inference...")

for i in range(len(X_scaled)):
    input_window = X_scaled[i].reshape(1, SEQ_LEN, 1).astype(np.float32)

    # THIS IS THE FIXED CALL ↓↓↓
    result = session.run([output_name], {input_name: input_window})

    scaled_out = result[0][0][0]
    unscaled_out = scaled_out * TEMP_STD + TEMP_MEAN

    predictions.append(unscaled_out)

predictions = np.array(predictions)

# ---------------------------------------------------------
# Compute metrics
# ---------------------------------------------------------
mse = np.mean((predictions - y) ** 2)
rmse = np.sqrt(mse)
mae = np.mean(np.abs(predictions - y))

print("\n-------------------------------------------------")
print("MODEL ACCURACY RESULTS")
print("-------------------------------------------------")
print(f"Samples tested: {len(predictions)}")
print(f"MAE : {mae:.4f}")
print(f"RMSE: {rmse:.4f}")
print(f"MSE : {mse:.4f}")
print("-------------------------------------------------\n")

# Show first 10
print("First 10 Predictions vs Actual:")
for i in range(10):
    print(f"{i+1:02d} | Predicted: {predictions[i]:.3f} | Actual: {y[i]:.3f}")
