import onnxruntime as ort
import numpy as np
import time
import psutil
import os
import subprocess

MODEL_PATH = "60percentPrunedQuantized.onnx"

def get_current_power_mw():
    """
    Reads the Pi 5's PMIC to get Instantaneous Power (VDD_CORE).
    Returns value in milliwatts (mW).
    """
    try:
        # Get Voltage
        v_out = subprocess.check_output(['vcgencmd', 'measure_volts', 'core']).decode()
        volts = float(v_out.split('=')[1].replace('V', ''))
        
        # Get Current (VDD_CORE_A rail)
        c_out = subprocess.check_output(['vcgencmd', 'pmic_read_adc', 'VDD_CORE_A']).decode()
        amps = float(c_out.split('=')[1].replace('A', ''))
        
        return (volts * amps) * 1000 # Convert W to mW
    except:
        return 0.0

def benchmark():
    print(f"--- Benchmarking {MODEL_PATH} ---")

    # 1. MEASURE IDLE STATE
    process = psutil.Process(os.getpid())
    ram_idle = process.memory_info().rss / 1024 # KB
    
    # Take 5 samples of idle power
    idle_powers = []
    for _ in range(5):
        idle_powers.append(get_current_power_mw())
        time.sleep(0.1)
    avg_idle_power = sum(idle_powers) / len(idle_powers)
    
    # 2. LOAD MODEL
    session = ort.InferenceSession(MODEL_PATH)
    
    # 3. MEASURE LOADED STATE (For RAM)
    ram_loaded = process.memory_info().rss / 1024 # KB
    marginal_ram = ram_loaded - ram_idle
    
    # Prepare Input
    input_name = session.get_inputs()[0].name
    input_shape = session.get_inputs()[0].shape
    # Fix dynamic axes
    fixed_shape = [1 if (isinstance(d, str) or d is None or d<0) else d for d in input_shape]
    dummy_input = np.random.randn(*fixed_shape).astype(np.float32)

    # Warmup
    for _ in range(50):
        session.run(None, {input_name: dummy_input})

    # 4. MEASURE ACTIVE STATE (For Latency & Power)
    latencies = []
    active_powers = []
    
    start_loop = time.time()
    # Run loop for 5 seconds to stabilize power reading
    while (time.time() - start_loop) < 5:
        t0 = time.time()
        session.run(None, {input_name: dummy_input})
        t1 = time.time()
        latencies.append((t1 - t0) * 1000)
        
        # Sample power during the run
        p = get_current_power_mw()
        if p > 0: active_powers.append(p)
        
    avg_active_power = sum(active_powers) / len(active_powers) if active_powers else 0
    marginal_power = avg_active_power - avg_idle_power

    # 5. REPORT
    print("\n" + "="*40)
    print(f"RESULTS FOR: {MODEL_PATH}")
    print("="*40)
    
    print(f"1. LATENCY (Target: < 50 ms)")
    print(f"   Actual: {sum(latencies)/len(latencies):.2f} ms")
    if (sum(latencies)/len(latencies)) < 50: print("   Status: PASSED ✅")
    else: print("   Status: FAILED ❌")
    
    print(f"\n2. MEMORY (Target: < 500 KB Marginal)")
    print(f"   Actual: {marginal_ram:.2f} KB")
    if marginal_ram < 500: print("   Status: PASSED ✅")
    else: print("   Status: FAILED ❌")

    print(f"\n3. POWER (Target: < 10 mW Marginal)")
    print(f"   Idle Power:   {avg_idle_power:.0f} mW")
    print(f"   Active Power: {avg_active_power:.0f} mW")
    print(f"   Model Usage:  {marginal_power:.0f} mW")
    if marginal_power < 10 and marginal_power > 0: print("   Status: PASSED ✅")
    else: print("   Status: FAILED ❌ (Physics limitation of Pi 5)")
    print("="*40)

if __name__ == "__main__":
    benchmark()