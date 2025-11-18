#Data generator for machines with some sensors on them

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from datetime import datetime, timedelta


# Time parameters
DAYS = 3 * 365   # 3 years
HOURS = DAYS * 24
START_DATE = datetime(2025, 1, 1)


T_BASE = 40.0
V_BASE = 15.0


T_NOISE_STD_BASE = 0.7
V_NOISE_STD_BASE = 1.2

T_EXTERNAL_AMPLITUDE = 6.0
T_SEASONAL_AMPLITUDE = 3.0
T_DAILY_PERIOD = 24.0


# V fails; T remains normal 
PRECURSOR_V_DURATION_HOURS = 24 * 2 #
PRECURSOR_V_AMPLITUDE = 8.0
FINAL_V_FAILURE_AMPLITUDE = 20.0 
FAILURE_V_RAMP = 4.0             
FAILURE_V_NOISE_FACTOR = 4.0
MAX_PRECURSOR_WAVE_DELAY_HOURS = 3 * 24 

#(Cooling  Failure)
# T fails; V remains normal 
FAILURE_T_PRECURSOR_HOURS = 24 * 3 
FAILURE_T_SPIKE = 25.0             
FAILURE_T_RAMP = 15.0              
FAILURE_T_NOISE_FACTOR = 1.5       

# --- General Simulation Configuration ---
# Probability of each state: [No Failure, V-Failure, T-Failure]
FAILURE_PROBABILITIES = [0.2, 0.4, 0.4] 


def generate_synthetic_data(machine_id):
    """Generates 3 years of synthetic sensor data for a single machine with a random failure time and mode."""
    print(f"  -> Generating data for Machine {machine_id}...")

    # Time array (0, 1, 2, ..., HOURS-1)
    time_in_hours = np.arange(HOURS)
    time_index = [START_DATE + timedelta(hours=int(t)) for t in time_in_hours]

    
    
    
    failure_state = np.random.choice([0, 1, 2], p=FAILURE_PROBABILITIES)
    FAILURE_OCCURRED = (failure_state != 0)
    
    mode_name = "No Failure (Mode 0)"
    if failure_state == 1:
        mode_name = "Vibration Failure (Mode 1)"
        
        FAILURE_DURATION_HOURS = np.random.randint(8, 15) * 24
    elif failure_state == 2:
        mode_name = "Temperature Failure (Mode 2)"
        
        FAILURE_DURATION_HOURS = FAILURE_T_PRECURSOR_HOURS

    
    PRECURSOR_EVENT_START_HOUR = -1
    FINAL_FAILURE_TRIGGER_HOUR = -1
    FINAL_FAILURE_DURATION_HOURS = 24 * 2 # Fixed instability duration
    
    if FAILURE_OCCURRED:
        
        PRECURSOR_EVENT_DAY = np.random.randint(100, 1000)
        PRECURSOR_EVENT_START_HOUR = PRECURSOR_EVENT_DAY * 24
        FINAL_FAILURE_TRIGGER_HOUR = PRECURSOR_EVENT_START_HOUR + FAILURE_DURATION_HOURS
    
        if FINAL_FAILURE_TRIGGER_HOUR + FINAL_FAILURE_DURATION_HOURS >= HOURS:
            
            print(f"  -> WARNING: Failure for Machine {machine_id} too late. Reverting to No Failure.")
            failure_state = 0
            FAILURE_OCCURRED = False
        
    print(f"  -> Assigned state: {mode_name}")

    
    T_noise_std_t = np.full(HOURS, T_NOISE_STD_BASE)
    V_noise_std_t = np.full(HOURS, V_NOISE_STD_BASE)
    
    failure_drift_t = np.zeros(HOURS)
    failure_drift_v = np.zeros(HOURS)

    is_precursor_period = np.zeros(HOURS, dtype=int)
    is_final_failure = np.zeros(HOURS, dtype=int)


    
    T_daily_cycle = T_EXTERNAL_AMPLITUDE * np.sin(2 * np.pi * time_in_hours / T_DAILY_PERIOD)
    T_seasonal_cycle = T_SEASONAL_AMPLITUDE * np.sin(2 * np.pi * time_in_hours / 8760)
    T_cycles = T_daily_cycle + T_seasonal_cycle
    
    
    V_cycles = np.zeros(HOURS)


    
    precursor_start_dt = pd.NaT
    final_failure_dt = pd.NaT
    duration_days = 'N/A'
    
    if FAILURE_OCCURRED:
        final_failure_end_hour = FINAL_FAILURE_TRIGGER_HOUR + FINAL_FAILURE_DURATION_HOURS
        precursor_start_dt = time_index[PRECURSOR_EVENT_START_HOUR]
        final_failure_dt = time_index[FINAL_FAILURE_TRIGGER_HOUR]
        duration_days = FAILURE_DURATION_HOURS / 24
        
        # Define the progression window for the precursor period
        failure_window_base = time_in_hours[(time_in_hours >= PRECURSOR_EVENT_START_HOUR) & (time_in_hours < FINAL_FAILURE_TRIGGER_HOUR)]
        progression_f = (failure_window_base - PRECURSOR_EVENT_START_HOUR) / FAILURE_DURATION_HOURS
        
        
        if failure_state == 1:
            
            drift_v_f = (progression_f**2) * FAILURE_V_RAMP
            failure_drift_v[failure_window_base] = drift_v_f

            
            V_noise_increase = progression_f * FAILURE_V_NOISE_FACTOR
            V_noise_std_t[failure_window_base] = V_NOISE_STD_BASE + V_noise_increase

           
            wave_delay_hours = np.random.randint(0, MAX_PRECURSOR_WAVE_DELAY_HOURS)
            wave_start_hour = PRECURSOR_EVENT_START_HOUR + wave_delay_hours
            wave_end_hour = wave_start_hour + PRECURSOR_V_DURATION_HOURS
            wave_period = np.random.uniform(2.5, 5.0) 
            precursor_wave_window = time_in_hours[(time_in_hours >= wave_start_hour) & (time_in_hours < wave_end_hour)]
            precursor_signal = PRECURSOR_V_AMPLITUDE * np.sin(2 * np.pi * (precursor_wave_window - wave_start_hour) / wave_period) 
            failure_drift_v[precursor_wave_window] += precursor_signal

            
            final_failure_window = time_in_hours[(time_in_hours >= FINAL_FAILURE_TRIGGER_HOUR) & (time_in_hours < final_failure_end_hour)]
            final_failure_signal = FINAL_V_FAILURE_AMPLITUDE * np.sin(np.pi * (final_failure_window - FINAL_FAILURE_TRIGGER_HOUR) / FINAL_FAILURE_DURATION_HOURS) 
            failure_drift_v[final_failure_window] += final_failure_signal
            
        # --- MODE 2: TEMPERATURE FAILURE ---
        elif failure_state == 2:
            
            drift_t_f = progression_f * FAILURE_T_RAMP
            failure_drift_t[failure_window_base] = drift_t_f
            
            
            T_noise_std_t[failure_window_base] = T_NOISE_STD_BASE * FAILURE_T_NOISE_FACTOR

            
            final_failure_window = time_in_hours[(time_in_hours >= FINAL_FAILURE_TRIGGER_HOUR) & (time_in_hours < final_failure_end_hour)]
            
            final_failure_signal = FAILURE_T_SPIKE * (final_failure_window - FINAL_FAILURE_TRIGGER_HOUR) / FINAL_FAILURE_DURATION_HOURS
            failure_drift_t[final_failure_window] += final_failure_signal

        
        is_precursor_period[PRECURSOR_EVENT_START_HOUR:FINAL_FAILURE_TRIGGER_HOUR] = 1
        is_final_failure[FINAL_FAILURE_TRIGGER_HOUR:final_failure_end_hour] = 1

    
    T_noise = np.random.normal(0, T_noise_std_t, HOURS)
    V_noise = np.random.normal(0, V_noise_std_t, HOURS)
    
    T_internal = T_BASE + T_cycles + failure_drift_t + T_noise
    V_sensor = V_BASE + V_cycles + failure_drift_v + V_noise
    
    
    data = pd.DataFrame({
        'machine_id': machine_id,
        'timestamp': time_index,
        'T_internal_sensor': T_internal,
        'V_sensor': V_sensor,
        
        # Flags for labeling/training
        'failure_mode': failure_state,
        'is_precursor_period': is_precursor_period,
        'is_final_failure': is_final_failure
    })
    
    summary = {
        'Machine ID': machine_id,
        'Failure State': mode_name,
        'Precursor Start': precursor_start_dt if FAILURE_OCCURRED else 'N/A',
        'Final Trigger': final_failure_dt if FAILURE_OCCURRED else 'N/A',
        'Duration (Days)': duration_days
    }
    
    # Call plotting function only if failure occurred
    if FAILURE_OCCURRED:
        create_plot(data, machine_id, PRECURSOR_EVENT_START_HOUR, FINAL_FAILURE_TRIGGER_HOUR, FINAL_FAILURE_DURATION_HOURS, failure_state)

    return data, summary


def create_plot(data, machine_id, precursor_start_hour, final_failure_trigger_hour, final_failure_duration_hours, failure_state):
    """Creates a zoomed plot focusing on the failed sensor for a single machine."""
    
   
    zoom_start_hour = precursor_start_hour - (5 * 24)
    zoom_end_hour = final_failure_trigger_hour + final_failure_duration_hours + (1 * 24)
    zoom_start_hour = max(0, zoom_start_hour)
    zoom_end_hour = min(HOURS - 1, zoom_end_hour)
    
    if zoom_start_hour >= zoom_end_hour:
        print(f"  -> Plotting error for Machine {machine_id}: Invalid zoom window.")
        return

    zoom_data = data.iloc[zoom_start_hour:zoom_end_hour].copy() 
    
    mode_title = "Vibration Failure (Mode 1)" if failure_state == 1 else "Temperature Failure (Mode 2)"
    failed_sensor = 'V_sensor' if failure_state == 1 else 'T_internal_sensor'
    failed_unit = 'Units (G)' if failure_state == 1 else '°C'
    
    fig, ax = plt.subplots(1, 1, figsize=(15, 6)) # Changed to a single subplot
    
    
    precursor_start_dt = zoom_data.iloc[0]['timestamp'] + timedelta(hours=int(precursor_start_hour - zoom_start_hour))
    final_failure_dt = zoom_data.iloc[0]['timestamp'] + timedelta(hours=int(final_failure_trigger_hour - zoom_start_hour))
    final_failure_end_dt = final_failure_dt + timedelta(hours=int(final_failure_duration_hours))

    
    ax.plot(zoom_data['timestamp'], zoom_data[failed_sensor], label=f'Failed Sensor: {failed_sensor}', linewidth=1.5, color='darkred')

    ax.axvline(x=precursor_start_dt, color='orange', linestyle=':', linewidth=2, label='Precursor Event Start')
    ax.axvline(x=final_failure_dt, color='red', linestyle='--', linewidth=3, label='Final Failure Trigger')

    
    ax.axvspan(precursor_start_dt, final_failure_dt, color='yellow', alpha=0.2, label='Precursor Period')
    ax.axvspan(final_failure_dt, final_failure_end_dt, color='red', alpha=0.2, label='Final Failure Instability')

    ax.set_title(f'Machine {machine_id} Failure Trace: {mode_title}', fontsize=14)
    ax.set_xlabel('Date and Time', fontsize=12) # Added xlabel back to the single plot
    ax.set_ylabel(f'{failed_sensor} ({failed_unit})', fontsize=12)
    ax.legend(loc='upper left')
    ax.grid(True, linestyle='--', alpha=0.6)

    plt.tight_layout()
    plt.savefig(f"./figure_{machine_id}")
    plt.show()
    plt.close(fig) 
    print(f"  -> Plot for Machine {machine_id} displayed.")


def main():
    """Main function to handle user input and run the simulation."""
    print("--- Multi-Machine Independent Failure Simulation (T and V only) ---")
    
    while True:
        try:
            num_machines = int(input("Enter the number of machines to simulate (e.g., 5): "))
            if num_machines <= 0:
                print("Please enter a positive number of machines.")
            else:
                break
        except ValueError:
            print("Invalid input. Please enter a whole number.")

    np.random.seed(42) # Set seed for overall reproducibility

    all_data = []
    all_summaries = []

    print(f"\nStarting simulation for {num_machines} machines. This may take a moment...")
    
    for i in range(1, num_machines + 1):
        data, summary = generate_synthetic_data(i)
        all_data.append(data)
        all_summaries.append(summary)

    
    final_df = pd.concat(all_data, ignore_index=True)
    csv_filename = f'synthetic_data_independent_failures_{num_machines}.csv'
    final_df.to_csv(csv_filename, index=False)

    # Display the failure summary
    summary_df = pd.DataFrame(all_summaries)
    
    print("\n" + "="*70)
    print("GENERATION COMPLETE")
    print(f"Total data points generated: {len(final_df)} (Approx. {HOURS * num_machines} total hours)")
    print(f"All data saved to: {csv_filename}")
    print("="*70)
    
    print("\nFAILURE SUMMARY (Precursor to Final Failure Trigger):")
    print(summary_df.to_string(index=False))


if __name__ == "__main__":
    main()