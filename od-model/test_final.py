import tensorflow as tf
import numpy as np
import cv2
import sys
import os
import glob
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.metrics import confusion_matrix

MODEL_PATH = 'cat_ultimate_final.tflite'
INPUT_SIZE = 128
THRESHOLD = 0.80 
OUTPUT_FOLDER = 'results'

def get_ground_truth(filename):
    return 'cat' in filename.lower()

def plot_results(y_true, y_pred, output_folder):
    # Calculate Standard Metrics
    cm = confusion_matrix(y_true, y_pred, labels=[0, 1])
    tn, fp, fn, tp = cm.ravel()
    
    precision = tp / (tp + fp) if (tp + fp) > 0 else 0
    recall = tp / (tp + fn) if (tp + fn) > 0 else 0
    accuracy = (tp + tn) / (tp + tn + fp + fn)
    
    print("\n" + "="*30)
    print(f"FINAL METRICS")
    print("="*30)
    print(f"Precision: {precision:.2%}")
    print(f"Recall:    {recall:.2%}")
    print(f"Accuracy:  {accuracy:.2%}")
    print(f"TP: {tp}, FP: {fp}, FN: {fn}, TN: {tn}")
    print("="*30)

    # Confusion Matrix
    plt.figure(figsize=(10, 4))
    
    plt.subplot(1, 2, 1)
    labels = ['No Cat', 'Cat']
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', xticklabels=labels, yticklabels=labels)
    plt.xlabel('Predicted')
    plt.ylabel('Actual')
    plt.title('Confusion Matrix')

    # Metrics Bar Chart
    plt.subplot(1, 2, 2)
    metrics = ['Precision', 'Recall', 'Accuracy']
    values = [precision, recall, accuracy]
    bars = plt.bar(metrics, values, color=['#3498db', '#e74c3c', '#2ecc71'])
    plt.ylim(0, 1.1)
    plt.title('Model Performance')
    plt.xlabel('Performance Metric')
    plt.ylabel('Score')
    
    for bar in bars:
        height = bar.get_height()
        plt.text(bar.get_x() + bar.get_width()/2., height,
                 f'{height:.1%}', ha='center', va='bottom')

    plt.tight_layout()
    save_path = os.path.join(output_folder, 'metrics_summary.png')
    plt.savefig(save_path)
    print(f"Metrics visualization saved to: {save_path}")
    plt.close()

def run_test():
    if len(sys.argv) < 2:
        print("Usage: python test_final.py <input_image_folder>")
        return

    input_folder = sys.argv[1]
    if not os.path.isdir(input_folder):
        print(f"Error: Folder '{input_folder}' not found.")
        return

    if not os.path.exists(OUTPUT_FOLDER):
        os.makedirs(OUTPUT_FOLDER)

    print(f"Loading Model: {MODEL_PATH}")
    try:
        interpreter = tf.lite.Interpreter(model_path=MODEL_PATH)
        interpreter.allocate_tensors()
    except Exception as e:
        print(f"Failed to load model: {e}")
        return
    
    input_details = interpreter.get_input_details()
    output_details = interpreter.get_output_details()
    
    in_scale, in_zero = input_details[0]['quantization']
    out_scale, out_zero = output_details[0]['quantization']

    extensions = ['*.jpg', '*.jpeg', '*.png', '*.bmp']
    image_files = []
    for ext in extensions:
        image_files.extend(glob.glob(os.path.join(input_folder, ext)))
        image_files.extend(glob.glob(os.path.join(input_folder, ext.upper())))
    
    print(f"Found {len(image_files)} images. Processing...")
    print("-" * 50)

    # 1 for Cat, 0 for No Cat
    y_true_list = [] 
    y_pred_list = [] 

    for img_path in image_files:
        filename = os.path.basename(img_path)
        
        is_actual_cat = get_ground_truth(filename)
        y_true_list.append(1 if is_actual_cat else 0)

        img_orig = cv2.imread(img_path)
        if img_orig is None: continue
        
        h_orig, w_orig = img_orig.shape[:2]
        img = cv2.resize(img_orig, (INPUT_SIZE, INPUT_SIZE))
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB).astype(np.float32) / 255.0
        
        # Quantize Input
        img_quant = (img / in_scale + in_zero).astype(np.int8)
        img_quant = np.expand_dims(img_quant, 0)

        interpreter.set_tensor(input_details[0]['index'], img_quant)
        interpreter.invoke()
        
        # Decode Output
        output_quant = interpreter.get_tensor(output_details[0]['index'])[0]
        output = (output_quant.astype(np.float32) - out_zero) * out_scale
        
        score = output[0]
        ymin, xmin, ymax, xmax = output[1], output[2], output[3], output[4]
        
        is_predicted_cat = score > THRESHOLD
        y_pred_list.append(1 if is_predicted_cat else 0)

        conf_str = f"{score*100:.1f}%"
        
        # Status Icon logic
        if is_predicted_cat and is_actual_cat: status = "✅ TP"
        elif is_predicted_cat and not is_actual_cat: status = "❌ FP"
        elif not is_predicted_cat and is_actual_cat: status = "❌ FN"
        else: status = "✅ TN"

        print(f"Processing {filename}: \t{status} (Conf: {conf_str})")
        
        if is_predicted_cat:
            # Draw Green Box
            x1, y1 = int(xmin * w_orig), int(ymin * h_orig)
            x2, y2 = int(xmax * w_orig), int(ymax * h_orig)
            
            x1, y1 = max(0, x1), max(0, y1)
            x2, y2 = min(w_orig, x2), min(h_orig, y2)
            
            cv2.rectangle(img_orig, (x1, y1), (x2, y2), (0, 255, 0), 3)
            cv2.putText(img_orig, f"CAT {conf_str}", (x1, y1-10), 
                        cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 255, 0), 2)
        else:
            # Draw Red Label
            cv2.putText(img_orig, f"NO CAT ({conf_str})", (10, 30), 
                        cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 0, 255), 2)

        save_path = os.path.join(OUTPUT_FOLDER, "pred_" + filename)
        cv2.imwrite(save_path, img_orig)

    print("-" * 50)
    
    if len(y_true_list) > 0:
        plot_results(y_true_list, y_pred_list, OUTPUT_FOLDER)
    else:
        print("No images processed.")

if __name__ == "__main__":
    run_test()