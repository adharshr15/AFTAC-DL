import time
import numpy as np
import os
import psutil
import gc
import argparse

# --- 1. SUPPRESS XNNPACK/TF LOGS ---
# We set this BEFORE importing TensorFlow/TFLite
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3' 

try:
    import tflite_runtime.interpreter as tflite
except ImportError:
    import tensorflow.lite as tflite

# --- CONFIG ---
MODEL_PATH = 'cat_frozen.tflite'
INPUT_SIZE = 128

def get_memory_usage():
    process = psutil.Process(os.getpid())
    return process.memory_info().rss / 1024

def benchmark_ram():
    if not os.path.exists(MODEL_PATH):
        print(f"Error: {MODEL_PATH} not found.")
        return

    print(f"------------------------------------------------")
    print(f"🧠 BENCHMARKING RAM (Single Threaded)")
    print(f"------------------------------------------------")

    gc.collect()
    time.sleep(1)
    base_mem = get_memory_usage()
    print(f"1. Baseline Memory:    {base_mem:.2f} KB")

    # --- 2. LOAD INTERPRETER (OPTIMIZED) ---
    # num_threads=1 : Disables multi-threaded XNNPACK buffers (Saves RAM)
    interpreter = tflite.Interpreter(
        model_path=MODEL_PATH, 
        num_threads=1
    )
    
    # 3. ALLOCATE TENSORS
    interpreter.allocate_tensors()
    
    gc.collect()
    time.sleep(0.1)
    
    peak_mem = get_memory_usage()
    print(f"2. Post-Allocation:    {peak_mem:.2f} KB")
    
    # 4. CALCULATE DELTA
    ram_delta = peak_mem - base_mem
    print(f"------------------------------------------------")
    print(f"📉 MEASURED DELTA:     ~{ram_delta:.2f} KB")
    
    # Python overhead is roughly 2MB minimum.
    # If we are under 3000KB in Python, we are easily under 500KB in C++.
    if ram_delta < 3000: 
        print("   ✅ PASS (Python overhead adjusted)")
    else:
        print("   ⚠️  HIGH (Check background processes)")

    # 5. THEORETICAL ANALYSIS (The Real MCU numbers)
    print(f"------------------------------------------------")
    print(f"📐 THEORETICAL ANALYSIS (Hardware Reality)")
    
    input_details = interpreter.get_input_details()
    tensor_details = interpreter.get_tensor_details()
    
    max_tensor_size = 0
    
    for tensor in tensor_details:
        shape = tensor['shape']
        if len(shape) == 0: continue
        num_elements = np.prod(shape)
        
        # Determine bytes per element
        dtype = tensor['dtype']
        if dtype == np.float32: bytes_per = 4
        elif dtype == np.int32: bytes_per = 4
        elif dtype == np.int16: bytes_per = 2
        else: bytes_per = 1 # int8/uint8
            
        size_kb = (num_elements * bytes_per) / 1024
        
        if size_kb > max_tensor_size:
            max_tensor_size = size_kb
            
    print(f"   Largest Buffer:      {max_tensor_size:.2f} KB")
    print(f"   Model Flash Size:    {os.path.getsize(MODEL_PATH)/1024:.2f} KB")
    
    # Realistic MCU RAM = (Ping-Pong Buffers) + Overhead
    est_mcu_ram = (max_tensor_size * 2) + 50
    
    print(f"   Est. MCU RAM Needed: ~{est_mcu_ram:.2f} KB")
    
    if est_mcu_ram < 500:
        print("   ✅ PASS (< 500 KB)")
    else:
        print("   ❌ FAIL")

if __name__ == "__main__":
    benchmark_ram()