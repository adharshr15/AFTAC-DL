###
# Train, prune, quantize, and evaluate SOH model
# (Copy of the cnn_prune.ipynb in the form of a .py file)
# ###

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import tempfile
import os

from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
import tensorflow as tf
from tensorflow.keras import layers, models
from tensorflow.keras.callbacks import EarlyStopping, ReduceLROnPlateau
import tf2onnx
import json

# Configuration
def load_parameters(path):
    """Load parameters from a JSON file into a dictionary"""
    with open(path, 'r') as f:
        params = json.load(f)
    
    print(f"Using parameters: {params}")
    return params

# Load configuration from JSON file
params = load_parameters('./config.json')
SELECT_MODEL = params.get('SELECT_MODEL', 0)
FORECAST_HORIZON = params.get('FORECAST_HORIZON', 1)
NUM_EPOCHS = params.get('NUM_EPOCHS', 10)
BATCH_SIZE = params.get('BATCH_SIZE', 32)

# Load preprocessed feature data
X_train_feature = np.load(f"./data/finalized/X_train_feature_{SELECT_MODEL}.npy")
Y_train_feature = np.load(f"./data/finalized/Y_train_feature_{SELECT_MODEL}.npy")
X_val_feature = np.load(f"./data/finalized/X_val_feature_{SELECT_MODEL}.npy")
Y_val_feature = np.load(f"./data/finalized/Y_val_feature_{SELECT_MODEL}.npy")
X_test_feature = np.load(f"./data/finalized/X_test_feature_{SELECT_MODEL}.npy")
Y_test_feature = np.load(f"./data/finalized/Y_test_feature_{SELECT_MODEL}.npy")

def create_cnn_model(seq_length, forecast_horizon):
    """
    Simple 1D CNN for time-series regression built with TensorFlow/Keras.
    Architecture: Conv1D -> MaxPool -> Dense -> Output
    """
    model = models.Sequential([
        layers.Input(shape=(seq_length, 1)),
        layers.Conv1D(filters=64, kernel_size=5, activation='relu', padding='valid'),
        layers.Dropout(0.25),
        layers.MaxPooling1D(pool_size=2),
        layers.Flatten(),
        layers.Dense(50, activation='relu'),
        layers.Dropout(0.25),
        layers.Dense(forecast_horizon)
    ])
    
    return model

def evaluate_model(model, X_test, Y_test):
    """Run predictions"""
    y_pred = model.predict(X_test, verbose=0)
    y_true = Y_test
    
    return y_true, y_pred

def print_metrics(y_true, y_pred, model_name="Model"):
    """Print regression metrics"""
    # Calculate metrics
    mse = mean_squared_error(y_true.flatten(), y_pred.flatten())
    mae = mean_absolute_error(y_true.flatten(), y_pred.flatten())
    rmse = np.sqrt(mse)
    r2 = r2_score(y_true.flatten(), y_pred.flatten())
    
    print(f"\n{model_name} Regression Metrics:")
    print(f"Mean Squared Error (MSE): {mse:.4f}")
    print(f"Root Mean Squared Error (RMSE): {rmse:.4f}")
    print(f"Mean Absolute Error (MAE): {mae:.4f}")
    print(f"R² Score: {r2:.4f}")
    
    return y_true, y_pred, mse, mae, rmse, r2

def evaluate_and_print_metrics(model, X_test, Y_test, model_name="Model"):
    y_true, y_pred = evaluate_model(model, X_test, Y_test)
    return print_metrics(y_true, y_pred, model_name)

def structured_prune_model(model, target_sparsity=0.5):
    """
    Structured pruning for TensorFlow/Keras models.
    Removes entire filters/neurons based on their L2 norm.
    
    Args:
        model: Trained Keras model to prune
        target_sparsity: Fraction of filters/neurons to prune (0.5 = 50%)
    
    Returns:
        Pruned model with removed filters/neurons
    """
    # Clone the model to avoid modifying the original
    pruned_model = tf.keras.models.clone_model(model)
    pruned_model.set_weights(model.get_weights())
    
    total_filters = 0
    pruned_filters = 0
    
    for layer in pruned_model.layers:
        if isinstance(layer, tf.keras.layers.Conv1D):
            # For Conv1D layers: prune filters based on L2 norm
            weights = layer.get_weights()
            if len(weights) > 0:
                kernel = weights[0]  # Shape: (kernel_size, in_channels, out_channels/filters)
                bias = weights[1] if len(weights) > 1 else None
                
                # Calculate L2 norm for each filter
                num_filters = kernel.shape[-1]
                total_filters += num_filters
                filter_norms = np.sqrt(np.sum(kernel ** 2, axis=(0, 1)))
                
                # Determine threshold for pruning
                num_to_prune = int(num_filters * target_sparsity)
                if num_to_prune >= num_filters:
                    num_to_prune = num_filters - 1  # Keep at least one filter
                
                # Get indices of filters to keep
                threshold = np.percentile(filter_norms, target_sparsity * 100)
                keep_mask = filter_norms >= threshold
                
                # Ensure we keep at least one filter
                if np.sum(keep_mask) == 0:
                    keep_mask[np.argmax(filter_norms)] = True
                
                # Apply mask to prune filters
                pruned_kernel = kernel[:, :, keep_mask]
                pruned_bias = bias[keep_mask] if bias is not None else None
                
                pruned_filters += num_filters - np.sum(keep_mask)
                
                # Update layer weights
                new_weights = [pruned_kernel]
                if pruned_bias is not None:
                    new_weights.append(pruned_bias)
                layer.set_weights(new_weights)
                
                # Print layer stats
                filters_remaining = np.sum(keep_mask)
                layer_sparsity = (num_filters - filters_remaining) / num_filters * 100
                print(f"Layer '{layer.name}': {layer_sparsity:.1f}% pruned ({num_filters - filters_remaining}/{num_filters} filters removed)")
                
        elif isinstance(layer, tf.keras.layers.Dense):
            # For Dense layers: prune neurons based on L2 norm
            weights = layer.get_weights()
            if len(weights) > 0:
                kernel = weights[0]  # Shape: (in_features, out_features)
                bias = weights[1] if len(weights) > 1 else None
                
                # Calculate L2 norm for each neuron (output dimension)
                num_neurons = kernel.shape[-1]
                total_filters += num_neurons
                neuron_norms = np.sqrt(np.sum(kernel ** 2, axis=0))
                
                # Determine threshold for pruning
                num_to_prune = int(num_neurons * target_sparsity)
                if num_to_prune >= num_neurons:
                    num_to_prune = num_neurons - 1  # Keep at least one neuron
                
                # Get indices of neurons to keep
                threshold = np.percentile(neuron_norms, target_sparsity * 100)
                keep_mask = neuron_norms >= threshold
                
                # Ensure we keep at least one neuron
                if np.sum(keep_mask) == 0:
                    keep_mask[np.argmax(neuron_norms)] = True
                
                # Apply mask to prune neurons
                pruned_kernel = kernel[:, keep_mask]
                pruned_bias = bias[keep_mask] if bias is not None else None
                
                pruned_filters += num_neurons - np.sum(keep_mask)
                
                # Update layer weights
                new_weights = [pruned_kernel]
                if pruned_bias is not None:
                    new_weights.append(pruned_bias)
                layer.set_weights(new_weights)
                
                # Print layer stats
                neurons_remaining = np.sum(keep_mask)
                layer_sparsity = (num_neurons - neurons_remaining) / num_neurons * 100
                print(f"Layer '{layer.name}': {layer_sparsity:.1f}% pruned ({num_neurons - neurons_remaining}/{num_neurons} neurons removed)")
    
    overall_sparsity = (pruned_filters / total_filters) * 100 if total_filters > 0 else 0
    print(f"\nOverall Structured Sparsity Achieved: {overall_sparsity:.2f}%")
    print(f"  Total filters/neurons: {total_filters:,}")
    print(f"  Pruned filters/neurons: {pruned_filters:,}")
    print(f"  Active filters/neurons: {total_filters - pruned_filters:,}")
    
    return pruned_model

def check_model_sparsity(model):
    """Calculate actual sparsity of the model after pruning"""
    total_weights = 0
    zero_weights = 0
    
    for layer in model.layers:
        if hasattr(layer, 'kernel'):
            weights = layer.get_weights()[0]
            total_weights += weights.size
            zero_weights += np.sum(weights == 0)
    
    sparsity_pct = (zero_weights / total_weights) * 100
    return sparsity_pct, total_weights, zero_weights

def representative_dataset_gen():
    """
    Generator function to provide representative samples for quantization.
    Uses a subset of training data.
    """
    num_calibration_samples = min(2000, len(X_train_feature))
    for i in range(num_calibration_samples):
        # Yield a single sample with correct shape for the model
        yield [X_train_feature[i:i+1].astype(np.float32)]

def train_model():
    """Train the CNN model and return the trained model with metrics"""
    print("\n" + "="*60)
    print("PHASE 1: MODEL TRAINING")
    print("="*60)
    
    # Build the TensorFlow/Keras CNN model
    model = create_cnn_model(X_train_feature.shape[1], FORECAST_HORIZON)
    
    # Compile the model
    model.compile(
        optimizer='adam',
        loss='mse',
        metrics=['mae']
    )
    
    model.summary()
    print("\nModel Architecture:")
    
    # Define callbacks
    early_stopping = EarlyStopping(monitor='val_loss', patience=5, restore_best_weights=True)
    reduce_lr = ReduceLROnPlateau(monitor='val_loss', factor=0.5, patience=3, min_lr=1e-6)
    callbacks = [early_stopping, reduce_lr]
    
    # Train the model
    history = model.fit(
        X_train_feature,
        Y_train_feature,
        validation_data=(X_val_feature, Y_val_feature),
        epochs=NUM_EPOCHS,
        batch_size=BATCH_SIZE,
        callbacks=callbacks,
        verbose=1
    )
    
    # Plot training and validation loss
    train_losses = history.history['loss']
    val_losses = history.history['val_loss']
    
    plt.figure(figsize=(10, 6))
    plt.plot(range(1, len(train_losses) + 1), train_losses, label='Training Loss', marker='o')
    plt.plot(range(1, len(val_losses) + 1), val_losses, label='Validation Loss', marker='s')
    plt.xlabel('Epoch')
    plt.ylabel('Loss (MSE)')
    plt.title('Training vs Validation Loss')
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    
    # Check for overfitting
    final_train_loss = train_losses[-1]
    final_val_loss = val_losses[-1]
    loss_diff = final_val_loss - final_train_loss
    loss_ratio = final_val_loss / final_train_loss
    
    print(f"\nFinal Training Loss: {final_train_loss:.4f}")
    print(f"Final Validation Loss: {final_val_loss:.4f}")
    print(f"Difference (Val - Train): {loss_diff:.4f}")
    print(f"Ratio (Val / Train): {loss_ratio:.2f}")
    
    # Evaluate the model
    print("\n--- Evaluating Model Performance ---")
    y_true, y_pred, mse, mae, rmse, r2 = evaluate_and_print_metrics(model, X_test_feature, Y_test_feature)
    
    # Visualize predictions
    y_true_flat = np.array(y_true).reshape(-1)
    y_pred_flat = np.array(y_pred).reshape(-1)
    
    plt.figure(figsize=(14, 6))
    
    # Sample a subset for visualization if too many points
    num_samples = min(200, len(y_true_flat))
    if num_samples > 0:
        indices = np.random.choice(len(y_true_flat), num_samples, replace=False)
        indices = np.sort(indices)
    
        plt.subplot(1, 2, 1)
        plt.plot(indices, y_true_flat[indices], 'b-', label='Actual', alpha=0.7)
        plt.plot(indices, y_pred_flat[indices], 'r--', label='Predicted', alpha=0.7)
        plt.xlabel('Sample Index')
        plt.ylabel('Sensor Value (Scaled)')
        plt.title(f'Predictions vs Actual\n{SELECT_MODEL}')
        plt.legend()
        plt.grid(True, alpha=0.3)
    
        plt.subplot(1, 2, 2)
        plt.scatter(y_true_flat, y_pred_flat, alpha=0.5)
        mn = min(y_true_flat.min(), y_pred_flat.min())
        mx = max(y_true_flat.max(), y_pred_flat.max())
        plt.plot([mn, mx], [mn, mx], 'r--', lw=2)
        plt.xlabel('Actual Values')
        plt.ylabel('Predicted Values')
        plt.title('Prediction Scatter Plot')
        plt.grid(True, alpha=0.3)
    
        plt.tight_layout()
        plt.show()
    
    return model, mse, mae, rmse, r2

def prune_model(model):
    """Prune the trained model and return the pruned model with metrics"""
    print("\n" + "="*60)
    print("PHASE 2: MODEL PRUNING (STRUCTURED)")
    print("="*60)
    
    # Apply structured pruning to your trained model
    pruned_model = structured_prune_model(model, target_sparsity=0.5)
    
    # Compile the pruned model
    pruned_model.compile(
        optimizer='adam',
        loss='mse',
        metrics=['mae']
    )
    
    # Fine-tune the pruned model to recover accuracy
    print("\n=== Fine-tuning Pruned Model ===")
    print("Training for 5 epochs to recover from pruning...\n")
    
    # Use lower learning rate for fine-tuning
    pruned_model.compile(
        optimizer=tf.keras.optimizers.Adam(learning_rate=0.0001),
        loss='mse',
        metrics=['mae']
    )
    
    # Define callbacks
    callbacks_pruned = [
        tf.keras.callbacks.EarlyStopping(monitor='val_loss', patience=3, restore_best_weights=True),
        tf.keras.callbacks.ReduceLROnPlateau(monitor='val_loss', factor=0.5, patience=2, min_lr=1e-7)
    ]
    
    # Fine-tune
    history_pruned = pruned_model.fit(
        X_train_feature,
        Y_train_feature,
        validation_data=(X_val_feature, Y_val_feature),
        epochs=5,
        batch_size=BATCH_SIZE,
        callbacks=callbacks_pruned,
        verbose=1
    )
    
    # Evaluate the pruned model
    print("\n=== Evaluating Pruned Model Performance ===")
    y_true_pruned, y_pred_pruned, mse_pruned, mae_pruned, rmse_pruned, r2_pruned = evaluate_and_print_metrics(
        pruned_model, X_test_feature, Y_test_feature, "Pruned Model"
    )
    
    # Verify sparsity
    sparsity, total, zeros = check_model_sparsity(pruned_model)
    print(f"\nVerified Sparsity: {sparsity:.2f}% ({zeros:,} / {total:,} weights are zero)")
    
    return pruned_model, mse_pruned, mae_pruned, rmse_pruned, r2_pruned

def quantize_model(pruned_model):
    """Quantize the pruned model and return quantized model with metrics"""
    print("\n" + "="*60)
    print("PHASE 3: MODEL QUANTIZATION")
    print("="*60)
    
    # Save the pruned model temporarily for quantization
    _, temp_model_path = tempfile.mkstemp(suffix='.h5', dir='./model')
    pruned_model.save(temp_model_path)
    print(f"Pruned model saved temporarily at: {temp_model_path}")
    
    print("\nRepresentative dataset generator created for quantization.")
    
    # Convert the pruned model to TensorFlow Lite with quantization
    converter = tf.lite.TFLiteConverter.from_keras_model(pruned_model)
    converter.optimizations = [tf.lite.Optimize.DEFAULT]
    converter.representative_dataset = representative_dataset_gen
    
    print("\nApplying dynamic range quantization...")
    quantized_tflite_model = converter.convert()
    
    print(f"\n--- Saving Pruned + Quantized Model ---")
    
    # Save tensorflow lite model
    quantized_model_path = './model/pruned_quantized_model.tflite'
    with open(quantized_model_path, 'wb') as f:
        f.write(quantized_tflite_model)
    
    print(f"TFLite Location: {quantized_model_path}")
    print(f"TFLite Size: {len(quantized_tflite_model) / 1024:.2f} KB")
    
    # Save onnx model
    onnx_model_path = "./model/pruned_quantized_model.onnx"
    spec = (tf.TensorSpec(pruned_model.inputs[0].shape, tf.float32, name="input"),)
    pruned_model.output_names = ["output"]
    model_proto, _ = tf2onnx.convert.from_keras(pruned_model, input_signature=spec, opset=13)
    
    with open(onnx_model_path, "wb") as f:
        f.write(model_proto.SerializeToString())
    
    print(f"\nONNX Location: {onnx_model_path}")
    print(f"ONNX Size: {os.path.getsize(onnx_model_path) / 1024:.2f} KB")
    
    # Evaluate the quantized TFLite model
    print("\n--- Evaluating Quantized Model ---")
    
    # Load the TFLite model
    interpreter = tf.lite.Interpreter(model_path=quantized_model_path)
    interpreter.allocate_tensors()
    
    # Get input and output details
    input_details = interpreter.get_input_details()
    output_details = interpreter.get_output_details()
    
    print(f"Input details: {input_details[0]['shape']}, dtype: {input_details[0]['dtype']}")
    print(f"Output details: {output_details[0]['shape']}, dtype: {output_details[0]['dtype']}")
    
    # Make predictions on test set
    quantized_predictions = []
    
    for i in range(len(X_test_feature)):
        # Prepare input
        input_data = X_test_feature[i:i+1].astype(input_details[0]['dtype'])
        
        # If input is int8, we need to quantize
        if input_details[0]['dtype'] == np.int8:
            input_scale, input_zero_point = input_details[0]['quantization']
            input_data = (input_data / input_scale + input_zero_point).astype(np.int8)
        
        interpreter.set_tensor(input_details[0]['index'], input_data)
        interpreter.invoke()
        
        # Get output
        output_data = interpreter.get_tensor(output_details[0]['index'])
        
        # If output is int8, we need to dequantize
        if output_details[0]['dtype'] == np.int8:
            output_scale, output_zero_point = output_details[0]['quantization']
            output_data = (output_data.astype(np.float32) - output_zero_point) * output_scale
        
        quantized_predictions.append(output_data[0])
    
    quantized_predictions = np.array(quantized_predictions)
    
    # Calculate metrics
    y_true_flat_quant = Y_test_feature.flatten()
    y_pred_flat_quant = quantized_predictions.flatten()
    
    _, _, mse_quantized, mae_quantized, rmse_quantized, r2_quantized = print_metrics(
        y_true_flat_quant, y_pred_flat_quant, "Quantized Model"
    )
    
    return temp_model_path, quantized_tflite_model, mse_quantized, mae_quantized, rmse_quantized, r2_quantized

def compare_models(original_model, pruned_model, quantized_tflite_model, temp_model_path,
                   mse_orig, mae_orig, r2_orig,
                   mse_pruned, mae_pruned, r2_pruned,
                   mse_quantized, mae_quantized, r2_quantized):
    """Compare all model versions - size and performance"""
    print("\n" + "="*60)
    print("PHASE 4: MODEL COMPARISON")
    print("="*60)
    
    # Get original model size
    _, original_model_path = tempfile.mkstemp(suffix='.h5', dir="./model")
    original_model.save(original_model_path)
    original_size = os.path.getsize(original_model_path)
    
    # Get pruned model size
    pruned_size = os.path.getsize(temp_model_path)
    
    # Get quantized model size
    quantized_size = len(quantized_tflite_model)
    
    print("\n=== Model Size Comparison ===")
    print(f"Original Model: {original_size / 1024:.2f} KB")
    print(f"Pruned Model: {pruned_size / 1024:.2f} KB ({(1 - pruned_size/original_size)*100:.1f}% reduction)")
    print(f"Pruned + Quantized Model: {quantized_size / 1024:.2f} KB ({(1 - quantized_size/original_size)*100:.1f}% reduction)")
    print(f"\nTotal compression: {original_size / quantized_size:.2f}x smaller")
    
    print("\n=== Performance Comparison ===")
    print(f"{'Model':<25} {'MSE':<10} {'MAE':<10} {'R²':<10}")
    print(f"{'-'*55}")
    print(f"{'Original':<25} {mse_orig:<10.4f} {mae_orig:<10.4f} {r2_orig:<10.4f}")
    print(f"{'Pruned':<25} {mse_pruned:<10.4f} {mae_pruned:<10.4f} {r2_pruned:<10.4f}")
    print(f"{'Pruned + Quantized':<25} {mse_quantized:<10.4f} {mae_quantized:<10.4f} {r2_quantized:<10.4f}")
    
    # Cleanup temporary files
    os.remove(original_model_path)
    os.remove(temp_model_path)
    
    # Visualize predictions comparison
    print("\n--- Generating comparison visualizations ---")
    
    # Get predictions from all models
    y_true, y_pred_orig = evaluate_model(original_model, X_test_feature, Y_test_feature)
    _, y_pred_pruned = evaluate_model(pruned_model, X_test_feature, Y_test_feature)
    
    # Get quantized predictions
    quantized_model_path = './model/pruned_quantized_model.tflite'
    interpreter = tf.lite.Interpreter(model_path=quantized_model_path)
    interpreter.allocate_tensors()
    input_details = interpreter.get_input_details()
    output_details = interpreter.get_output_details()
    
    quantized_predictions = []
    for i in range(len(X_test_feature)):
        input_data = X_test_feature[i:i+1].astype(input_details[0]['dtype'])
        if input_details[0]['dtype'] == np.int8:
            input_scale, input_zero_point = input_details[0]['quantization']
            input_data = (input_data / input_scale + input_zero_point).astype(np.int8)
        
        interpreter.set_tensor(input_details[0]['index'], input_data)
        interpreter.invoke()
        output_data = interpreter.get_tensor(output_details[0]['index'])
        
        if output_details[0]['dtype'] == np.int8:
            output_scale, output_zero_point = output_details[0]['quantization']
            output_data = (output_data.astype(np.float32) - output_zero_point) * output_scale
        
        quantized_predictions.append(output_data[0])
    
    y_pred_quant = np.array(quantized_predictions)
    
    # Flatten for plotting
    y_true_flat = y_true.flatten()
    y_pred_orig_flat = y_pred_orig.flatten()
    y_pred_pruned_flat = y_pred_pruned.flatten()
    y_pred_quant_flat = y_pred_quant.flatten()
    
    plt.figure(figsize=(16, 5))
    
    num_samples = min(150, len(y_true_flat))
    if num_samples > 0:
        indices = np.random.choice(len(y_true_flat), num_samples, replace=False)
        indices = np.sort(indices)
    
        # Plot 1: Time series comparison
        plt.subplot(1, 3, 1)
        plt.plot(indices, y_true_flat[indices], 'b-', label='Actual', alpha=0.7, linewidth=2)
        plt.plot(indices, y_pred_orig_flat[indices], 'g--', label='Original', alpha=0.7)
        plt.plot(indices, y_pred_pruned_flat[indices], 'r--', label='Pruned', alpha=0.7)
        plt.plot(indices, y_pred_quant_flat[indices], 'm--', label='Quantized', alpha=0.7)
        plt.xlabel('Sample Index')
        plt.ylabel('Sensor Value (Scaled)')
        plt.title('Predictions Comparison')
        plt.legend()
        plt.grid(True, alpha=0.3)
    
        # Plot 2: Original vs Quantized scatter
        plt.subplot(1, 3, 2)
        plt.scatter(y_true_flat, y_pred_orig_flat, alpha=0.3, label='Original')
        plt.scatter(y_true_flat, y_pred_quant_flat, alpha=0.3, label='Quantized')
        mn = min(y_true_flat.min(), y_pred_orig_flat.min(), y_pred_quant_flat.min())
        mx = max(y_true_flat.max(), y_pred_orig_flat.max(), y_pred_quant_flat.max())
        plt.plot([mn, mx], [mn, mx], 'r--', lw=2)
        plt.xlabel('Actual Values')
        plt.ylabel('Predicted Values')
        plt.title('Scatter: Original vs Quantized')
        plt.legend()
        plt.grid(True, alpha=0.3)
    
        # Plot 3: Error distribution
        plt.subplot(1, 3, 3)
        error_original = np.abs(y_true_flat - y_pred_orig_flat)
        error_pruned = np.abs(y_true_flat - y_pred_pruned_flat)
        error_quantized = np.abs(y_true_flat - y_pred_quant_flat)
        
        plt.hist(error_original, bins=30, alpha=0.5, label='Original', color='green')
        plt.hist(error_pruned, bins=30, alpha=0.5, label='Pruned', color='red')
        plt.hist(error_quantized, bins=30, alpha=0.5, label='Quantized', color='magenta')
        plt.xlabel('Absolute Error')
        plt.ylabel('Frequency')
        plt.title('Error Distribution')
        plt.legend()
        plt.grid(True, alpha=0.3)
    
        plt.tight_layout()
        plt.show()
    else:
        print("No test samples available to plot.")

def main():
    """Main function to run the complete model training, pruning, quantization, and comparison pipeline"""
    # Phase 1: Train the original model
    original_model, mse_orig, mae_orig, rmse_orig, r2_orig = train_model()
    
    # Phase 2: Prune the model
    pruned_model, mse_pruned, mae_pruned, rmse_pruned, r2_pruned = prune_model(original_model)
    
    # Phase 3: Quantize the pruned model
    temp_model_path, quantized_tflite_model, mse_quantized, mae_quantized, rmse_quantized, r2_quantized = quantize_model(pruned_model)
    
    # Phase 4: Compare all models
    compare_models(
        original_model, pruned_model, quantized_tflite_model, temp_model_path,
        mse_orig, mae_orig, r2_orig,
        mse_pruned, mae_pruned, r2_pruned,
        mse_quantized, mae_quantized, r2_quantized
    )
    
    print("\n" + "="*60)
    print("PIPELINE COMPLETE")
    print("="*60)

if __name__ == "__main__":
    main()