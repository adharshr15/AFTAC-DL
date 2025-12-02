import tensorflow as tf
import numpy as np
import cv2
import sys
import os

MODEL_PATH = 'cat_frozen.tflite'
INPUT_SIZE = 128
THRESHOLD = 0.50 # Since we trained with hard negatives, 50% is a safe cutoff

def run_test():
    if len(sys.argv) < 2:
        print("Usage: python test_robust.py image.jpg")
        return
    image_path = sys.argv[1]
    
    interpreter = tf.lite.Interpreter(model_path=MODEL_PATH)
    interpreter.allocate_tensors()
    input_idx = interpreter.get_input_details()[0]['index']
    output_idx = interpreter.get_output_details()[0]['index']
    in_scale, in_zero = interpreter.get_input_details()[0]['quantization']
    out_scale, out_zero = interpreter.get_output_details()[0]['quantization']

    img_orig = cv2.imread(image_path)
    if img_orig is None: return
    h_orig, w_orig = img_orig.shape[:2]
    
    img = cv2.resize(img_orig, (INPUT_SIZE, INPUT_SIZE))
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB).astype(np.float32) / 255.0
    img_quant = (img / in_scale + in_zero).astype(np.int8)
    img_quant = np.expand_dims(img_quant, 0)

    interpreter.set_tensor(input_idx, img_quant)
    interpreter.invoke()
    
    output_quant = interpreter.get_tensor(output_idx)[0]
    output = (output_quant.astype(np.float32) - out_zero) * out_scale
    
    score = output[0]
    ymin, xmin, ymax, xmax = output[1], output[2], output[3], output[4]
    
    print(f"--------------------------")
    print(f"Confidence: {score*100:.1f}%")
    
    if score > THRESHOLD:
        print("RESULT: 🐱 CAT DETECTED")
        x1 = int(xmin * w_orig)
        y1 = int(ymin * h_orig)
        x2 = int(xmax * w_orig)
        y2 = int(ymax * h_orig)
        
        # Clamp
        x1, y1 = max(0, x1), max(0, y1)
        x2, y2 = min(w_orig, x2), min(h_orig, y2)

        cv2.rectangle(img_orig, (x1, y1), (x2, y2), (0, 255, 0), 3)
        cv2.putText(img_orig, f"CAT {score*100:.0f}%", (x1, y1-10), 
                    cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 255, 0), 2)
    else:
        print("RESULT: ❌ NO CAT")
        cv2.putText(img_orig, "NO CAT", (10, 50), 
                    cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2)
        
    cv2.imwrite("result_final.jpg", img_orig)
    print("Saved result_final.jpg")
    print(f"--------------------------")

if __name__ == "__main__":
    run_test()