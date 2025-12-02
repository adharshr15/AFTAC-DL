import pandas as pd

df = pd.read_csv("./public/assets/synthetic_data_independent_failures_4.csv")

# Convert timestamps to real datetime objects
df["timestamp"] = pd.to_datetime(df["timestamp"])

# Sort by timestamp, then machine_id
df_sorted = df.sort_values(["timestamp", "machine_id"])

# Save the result
df_sorted.to_csv("synthetic_data_independent_failures_4_gb_timestamp.csv", index=False)

print("Saved synthetic_data_independent_failures_4_gb_timestamp.csv")
