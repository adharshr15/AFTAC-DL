import tensorflow as tf
import numpy as np
import cv2
import sys
import os

MODEL_PATH = 'cat_final_v2.tflite'
INPUT_SIZE = 128

def run_test():
    if len(sys.argv) < 2:
        image_path = "test.jpg"
    else:
        image_path = sys.argv[1]
    
    # 1. Load
    interpreter = tf.lite.Interpreter(model_path=MODEL_PATH)
    interpreter.allocate_tensors()
    input_idx = interpreter.get_input_details()[0]['index']
    output_idx = interpreter.get_output_details()[0]['index']
    in_scale, in_zero = interpreter.get_input_details()[0]['quantization']
    out_scale, out_zero = interpreter.get_output_details()[0]['quantization']

    # 2. Prep
    img_orig = cv2.imread(image_path)
    if img_orig is None:
        print("Could not load image.")
        return
    h_orig, w_orig = img_orig.shape[:2]
    
    img = cv2.resize(img_orig, (INPUT_SIZE, INPUT_SIZE))
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB).astype(np.float32) / 255.0
    img_quant = (img / in_scale + in_zero).astype(np.int8)
    img_quant = np.expand_dims(img_quant, 0)

    # 3. Run
    interpreter.set_tensor(input_idx, img_quant)
    interpreter.invoke()
    
    # 4. Output
    output_quant = interpreter.get_tensor(output_idx)[0]
    output = (output_quant.astype(np.float32) - out_zero) * out_scale
    
    score = output[0]
    ymin, xmin, ymax, xmax = output[1], output[2], output[3], output[4]
    
    # --- DEBUG PRINTS ---
    print(f"-----------------------------------")
    print(f"RAW OUTPUT: {output}")
    print(f"CONFIDENCE: {score*100:.2f}%")
    print(f"BOX COORDS: {ymin:.2f}, {xmin:.2f}, {ymax:.2f}, {xmax:.2f}")
    print(f"-----------------------------------")

    # Draw if confidence > 10% (Low threshold just to see what it's trying to do)
    if score > 0.10:
        x1 = int(xmin * w_orig)
        y1 = int(ymin * h_orig)
        x2 = int(xmax * w_orig)
        y2 = int(ymax * h_orig)
        
        # Clamp coordinates
        x1, y1 = max(0, x1), max(0, y1)
        x2, y2 = min(w_orig, x2), min(h_orig, y2)

        color = (0, 255, 0) if score > 0.5 else (0, 0, 255) # Green if good, Red if low confidence
        
        cv2.rectangle(img_orig, (x1, y1), (x2, y2), color, 3)
        cv2.putText(img_orig, f"{score:.2f}", (x1, y1-10), cv2.FONT_HERSHEY_SIMPLEX, 0.8, color, 2)
        
    cv2.imwrite("result_debug.jpg", img_orig)
    print("Saved result_debug.jpg")

if __name__ == "__main__":
    run_test()