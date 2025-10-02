

#!/usr/bin/env python3
"""


Synthetic temperature‑sensor data generator with:
  • optional day/night sinusoidal flux,
  • rare high‑temperature spikes that indicate imminent failure,
  • per‑sensor randomisation of spike rate and daily phase,
  • a binary label (0 = normal, 1 = anomaly),
  • CSV export (all, normal only, anomalies only),
  • quick matplotlib visualisation,
  • command‑line interface (works in Spyder, terminal, etc.).

"""

# ------------------------------------------------------------
# Imports
# ------------------------------------------------------------
import argparse
import random
from datetime import timedelta
from pathlib import Path
import sys

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
#################################################################################################################################################
# ------------------------------------------------------------
# Helper: parse strings like "12h", "30m", "10s"
# ------------------------------------------------------------
def _to_timedelta(s: str) -> timedelta:
    """Convert a human‑readable duration to a datetime.timedelta."""
    units = {"h": "hours", "m": "minutes", "s": "seconds"}
    try:
        value = int(s[:-1])
        unit = s[-1].lower()
        if unit not in units:
            raise ValueError
        return timedelta(**{units[unit]: value})
    except Exception:
        raise argparse.ArgumentTypeError(
            f"Invalid duration '{s}'. Use e.g. '12h', '30m', '10s'."
        )

###############################################################################################################################################
# ------------------------------------------------------------
# Core generator – one sensor 
# ------------------------------------------------------------
def generate_sensor_series(
    sensor_id: int,
    start: pd.Timestamp,
    end: pd.Timestamp,
    freq: str = "1s",
    # ── Ambient (random) component
    base_temp_min: float = 20.0,
    base_temp_max: float = 30.0,
    noise_std: float = 0.3,
    # ── Daily sinusoidal component
    use_daily_cycle: bool = True,
    daily_mean: float = 25.0,          # average temperature over 24 h
    daily_amp: float = 5.0,            # ± amplitude around the mean
    daily_phase: float = 0.0,          # phase shift in **hours** (0 = midnight minimum)
    # ── Spike / anomaly component
    spike_temp: float = 90.0,
    spike_rate_per_hour: float = 0.02,
    spike_len_min: int = 30,
    spike_len_max: int = 180,
    cooldown_min: int = 300,
    cooldown_max: int = 900,
    rng: np.random.Generator = None,
) -> pd.DataFrame:
    """
    Simulate one temperature sensor.

    Returns a DataFrame with columns:
        timestamp, sensor_id, temperature, label
    label == 0 → normal reading,
    label == 1 → anomaly (high‑temperature spike).
    """
    if rng is None:
        rng = np.random.default_rng()

    step = pd.tseries.frequencies.to_offset(freq)
    steps_per_hour = int(timedelta(hours=1) / step.delta)
    p_start_spike = spike_rate_per_hour / steps_per_hour

    timestamps, temps, ids, labels = [], [], [], []

    state = "normal"
    spike_end = None
    cooldown_end = None

    cur = start
    while cur <= end:
        # --------------------------------------------------------
        #Compute the “normal” temperature 
        # --------------------------------------------------------
        if use_daily_cycle:
            # hour_of_day as a float in [0, 24)
            hour_of_day = cur.hour + cur.minute / 60 + cur.second / 3600
            # phase expressed as fraction of a day
            phase_frac = daily_phase / 24.0
            sinusoid = np.sin(2 * np.pi * (hour_of_day / 24.0 + phase_frac))
            daily_component = daily_mean + daily_amp * sinusoid
        else:
            daily_component = 0.0

        ambient = rng.uniform(base_temp_min, base_temp_max)
        normal_temp = ambient + daily_component

        # --------------------------------------------------------
        # State machine 
        # --------------------------------------------------------
        if state == "normal":
            if rng.random() < p_start_spike:
                # ---- start a spike ---------------------------------
                state = "spike"
                spike_len = rng.integers(spike_len_min, spike_len_max + 1)
                spike_end = cur + pd.Timedelta(seconds=spike_len)

                temperature = spike_temp + rng.normal(0, noise_std)
                timestamps.append(cur); temps.append(temperature)
                ids.append(sensor_id); labels.append(1)

                cur += step
                continue

            # ---- ordinary reading ---------------------------------
            temperature = normal_temp + rng.normal(0, noise_std)
            timestamps.append(cur); temps.append(temperature)
            ids.append(sensor_id); labels.append(0)

        elif state == "spike":
            if cur >= spike_end:
                # ---- spike finished → cooling -----------------------
                state = "cooldown"
                cooldown_len = rng.integers(cooldown_min, cooldown_max + 1)
                cooldown_end = cur + pd.Timedelta(seconds=cooldown_len)
            else:
                temperature = spike_temp + rng.normal(0, noise_std)
                timestamps.append(cur); temps.append(temperature)
                ids.append(sensor_id); labels.append(1)

        elif state == "cooldown":
            if cur >= cooldown_end:
                # ---- cooling over → back to normal -----------------
                state = "normal"
                temperature = normal_temp + rng.normal(0, noise_std)
                timestamps.append(cur); temps.append(temperature)
                ids.append(sensor_id); labels.append(0)
            else:
                # silent period – no row emitted
                pass

        cur += step

    return pd.DataFrame(
        {
            "timestamp": timestamps,
            "sensor_id": ids,
            "temperature": temps,
            "label": labels,
        }
    )
##################################################################################################################################################

# ------------------------------------------------------------
# Multi‑sensor wrapper ( per‑sensor randomisation)
# ------------------------------------------------------------
def generate_multi_sensor_dataset(
    n_sensors: int = 3,
    duration: str = "12h",
    freq: str = "1s",
    seed: int | None = None,
    # ── Per‑sensor randomisation ranges ───────────────────────────────
    spike_rate_range: tuple[float, float] = (0.015, 0.025),
    daily_phase_range: tuple[float, float] = (0.0, 24.0),
    # ── Any extra kwargs are passed to generate_sensor_series ------------
    **sensor_kwargs,
) -> pd.DataFrame:
    """
    Simulate *n_sensors* independent streams and concatenate them.
    Each sensor receives:
        * a random spike rate drawn from *spike_rate_range*,
        * a random daily_phase drawn from *daily_phase_range*.
    This guarantees that anomalies are not synchronized across sensors.
    """
    rng = np.random.default_rng(seed)

    start = pd.Timestamp.now().floor("S")
    end = start + _to_timedelta(duration)

    frames = []
    for sid in range(1, n_sensors + 1):
        # Independent RNG for the sensor
        sub_rng = np.random.default_rng(rng.integers(0, 2**32 - 1))

        # Random per‑sensor parameters
        this_spike_rate = rng.uniform(*spike_rate_range)
        this_phase = rng.uniform(*daily_phase_range)

        df = generate_sensor_series(
            sensor_id=sid,
            start=start,
            end=end,
            freq=freq,
            rng=sub_rng,
            spike_rate_per_hour=this_spike_rate,
            daily_phase=this_phase,
            **sensor_kwargs,
        )
        frames.append(df)

    return pd.concat(frames).sort_values("timestamp").reset_index(drop=True)

#################################################################################################################################################
# ------------------------------------------------------------
# Plotting helper (normal = blue, anomaly = red)
# ------------------------------------------------------------
def plot_sensor_data(df: pd.DataFrame, sensor_ids: list | None = None, figsize=(14, 5)):
    """Line‑plot of temperature with red markers on anomaly points."""
    if sensor_ids is None:
        sensor_ids = sorted(df["sensor_id"].unique())

    plt.figure(figsize=figsize)
    for sid in sensor_ids:
        sub = df[df["sensor_id"] == sid]
        # normal points
        plt.plot(
            sub[sub["label"] == 0]["timestamp"],
            sub[sub["label"] == 0]["temperature"],
            label=f"S{sid} normal",
            linewidth=1,
        )
        # anomaly points
        plt.scatter(
            sub[sub["label"] == 1]["timestamp"],
            sub[sub["label"] == 1]["temperature"],
            color="red",
            s=10,
            label=f"S{sid} anomaly",
            zorder=5,
        )
    plt.xlabel("Timestamp")
    plt.ylabel("Temperature (°C)")
    plt.title("Synthetic temperature streams – normal vs. anomaly")
    plt.legend()
    plt.tight_layout()
    plt.show()
#################################################################################################################################################

# ------------------------------------------------------------
#CSV writer (all, normal, anomalies)
# ------------------------------------------------------------
def write_csvs(df: pd.DataFrame, folder: Path = Path("simulated_dataset")):
    """Write three CSV files: all data, normal only, anomalies only."""
    folder.mkdir(parents=True, exist_ok=True)

    all_path = folder / "all_data.csv"
    normal_path = folder / "normal.csv"
    anomaly_path = folder / "anomalies.csv"

    df.to_csv(all_path, index=False)
    df[df["label"] == 0].to_csv(normal_path, index=False)
    df[df["label"] == 1].to_csv(anomaly_path, index=False)

    print(f"✔️  Saved: {all_path}")
    print(f"✔️  Saved: {normal_path}   (rows: {len(df[df['label']==0])})")
    print(f"✔️  Saved: {anomaly_path} (rows: {len(df[df['label']==1])})")

##################################################################################################################################################
# ------------------------------------------------------------
# Demo / entry‑point (runs when the file is executed)
# ------------------------------------------------------------
def _demo():
    """Run a quick demo – generate, save, and plot."""
    print("\n=== Temperature‑sensor simulation demo (randomised anomalies) ===\n")
    df = generate_multi_sensor_dataset(
        n_sensors=4,
        duration="6h",
        freq="1s",
        seed=123,
        # per‑sensor randomisation (feel free to adjust)
        spike_rate_range=(0.015, 0.025),
        daily_phase_range=(0.0, 24.0),
        # daily‑cycle parameters
        use_daily_cycle=True,
        daily_mean=25.0,
        daily_amp=5.0,
        # spike parameters (same for all sensors, only the *rate* varies)
        spike_temp=90.0,
        spike_len_min=45,
        spike_len_max=120,
        cooldown_min=300,
        cooldown_max=600,
    )
    print(f"Generated {len(df)} rows (including {df['label'].sum()} anomalies)")

    write_csvs(df)
    plot_sensor_data(df)




###############################################################################################################################################





if __name__ == "__main__":
    # -----------------------------------------------------------------
    # Command‑line interface – all arguments are optional.
    # -----------------------------------------------------------------
    parser = argparse.ArgumentParser(
        description=(
            "Generate synthetic temperature‑sensor data with randomised "
            "spikes and optional day/night cycle."
        )
    )
    parser.add_argument("-n", "--sensors", type=int, default=4,
                        help="Number of sensors to simulate")
    parser.add_argument("-d", "--duration", default="6h",
                        help="Simulation length (e.g. 6h, 1d)")
    parser.add_argument("-f", "--freq", default="1s",
                        help="Sampling frequency (pandas offset string)")
    parser.add_argument("-s", "--seed", type=int, default=123,
                        help="Random seed for reproducibility")
    parser.add_argument("--no-daily-cycle", action="store_true",
                        help="Disable the day/night sinusoidal component")
    parser.add_argument("--daily-mean", type=float, default=25.0,
                        help="Mean temperature for the daily sinusoid")
    parser.add_argument("--daily-amp", type=float, default=5.0,
                        help="Amplitude of the daily sinusoid (± around mean)")
    # Optional explicit per‑sensor ranges (defaults give a small random spread)
    parser.add_argument("--spike-rate-min", type=float, default=0.015,
                        help="Minimum spike rate (spikes per hour) per sensor")
    parser.add_argument("--spike-rate-max", type=float, default=0.025,
                        help="Maximum spike rate (spikes per hour) per sensor")
    parser.add_argument("--daily-phase-min", type=float, default=0.0,
                        help="Minimum daily phase (hours) per sensor")
    parser.add_argument("--daily-phase-max", type=float, default=24.0,
                        help="Maximum daily phase (hours) per sensor")
    args = parser.parse_args()

    spike_range = (args.spike_rate_min, args.spike_rate_max)
    phase_range = (args.daily_phase_min, args.daily_phase_max)

    df_demo = generate_multi_sensor_dataset(
        n_sensors=args.sensors,
        duration=args.duration,
        freq=args.freq,
        seed=args.seed,
        spike_rate_range=spike_range,
        daily_phase_range=phase_range,
        use_daily_cycle=not args.no_daily_cycle,
        daily_mean=args.daily_mean,
        daily_amp=args.daily_amp,
        # other spike parameters keep their defaults
    )
    write_csvs(df_demo)
    plot_sensor_data(df_demo)