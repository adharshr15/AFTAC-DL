# %pip install tensorflow
# %pip install tensorflow-datasets
# %pip install tensorflow-model-optimization
# %pip install tf_keras

import os
os.environ["TF_USE_LEGACY_KERAS"] = "1"

import tensorflow as tf
import tensorflow_datasets as tfds
from tensorflow import keras
from tensorflow.keras import layers, Model, applications, callbacks
import numpy as np
import tensorflow_model_optimization as tfmot
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.metrics import confusion_matrix

INPUT_SIZE = 128
ALPHA = 0.45
BATCH_SIZE = 32
EPOCHS = 150

def cat_accuracy(y_true, y_pred):
    true_label = y_true[:, 0]
    pred_label = y_pred[:, 0]
    return keras.metrics.binary_accuracy(true_label, pred_label)

def load_data():
    print("Loading Data")
    # Load BOTH splits
    pets_train, pets_test = tfds.load('oxford_iiit_pet:4.0.0', split=['train', 'test'], with_info=False)
    caltech_train, caltech_test = tfds.load('caltech101', split=['train', 'test'], with_info=False)

    def build_pipeline(pets_ds, universe_ds, is_training=True):
        # Cats (Positives)
        cats = pets_ds.filter(lambda x: x['species'] == 0)
        if is_training: cats = cats.take(2500)
        else: cats = cats.take(500)

        cats = cats.map(lambda x: (x['image'], True, x['segmentation_mask']))

        # Universe (Negatives)
        def fmt_neg(x):
            h, w = tf.shape(x['image'])[0], tf.shape(x['image'])[1]
            return x['image'], False, tf.zeros((h, w, 1), dtype=tf.uint8)

        if is_training: universe = universe_ds.take(2500)
        else: universe = universe_ds.take(500)

        universe = universe.map(fmt_neg)

        # Combine
        dataset = cats.concatenate(universe)
        if is_training:
            dataset = dataset.shuffle(5000)

        # Preprocessing Logic
        def get_bbox(mask):
            mask = tf.cast(mask, tf.int32)
            pixels = tf.where(tf.equal(mask, 1))
            def found():
                ymin = tf.reduce_min(pixels[:, 0])
                xmin = tf.reduce_min(pixels[:, 1])
                ymax = tf.reduce_max(pixels[:, 0])
                xmax = tf.reduce_max(pixels[:, 1])
                return tf.cast(ymin, tf.float32), tf.cast(xmin, tf.float32), tf.cast(ymax, tf.float32), tf.cast(xmax, tf.float32)
            def empty(): return 0.0, 0.0, 0.0, 0.0
            return tf.cond(tf.greater(tf.shape(pixels)[0], 0), found, empty), tf.shape(mask)

        def preprocess(image, is_cat, mask):
            # Augmentation
            if is_training:
                image = tf.image.random_flip_left_right(image)
                image = tf.image.random_brightness(image, 0.2)
                image = tf.image.random_contrast(image, 0.8, 1.2)
                image = tf.image.random_saturation(image, 0.8, 1.2)

            # Standard Resize & Normalize
            img = tf.image.resize(image, (INPUT_SIZE, INPUT_SIZE))
            img = tf.cast(img, tf.float32) / 255.0

            # Box Logic
            def get_box():
                box, shape = get_bbox(mask)
                y, x, y2, x2 = box
                h, w = tf.cast(shape[0], tf.float32), tf.cast(shape[1], tf.float32)
                return tf.stack([y/tf.maximum(h,1.0), x/tf.maximum(w,1.0), y2/tf.maximum(h,1.0), x2/tf.maximum(w,1.0)])

            box = tf.cond(is_cat, get_box, lambda: tf.constant([0.0,0.0,0.0,0.0]))
            score = tf.cast(is_cat, tf.float32)
            return img, tf.concat([[score], box], axis=0)

        # Apply mapping
        ds = dataset.map(preprocess, num_parallel_calls=tf.data.AUTOTUNE)
        ds = ds.batch(BATCH_SIZE).prefetch(tf.data.AUTOTUNE)
        return ds

    train_ds = build_pipeline(pets_train, caltech_train, is_training=True)
    val_ds = build_pipeline(pets_test, caltech_test, is_training=False)

    return train_ds, val_ds

def create_model():
    base = keras.applications.MobileNetV2(
        input_shape=(128, 128, 3),
        alpha=ALPHA,
        include_top=False,
        weights=None
    )
    base.trainable = True

    x = base.get_layer('block_13_project_BN').output
    x = keras.layers.GlobalAveragePooling2D()(x)
    x = keras.layers.Dropout(0.2)(x)
    outputs = keras.layers.Dense(5, activation='sigmoid')(x)
    return keras.Model(inputs=base.input, outputs=outputs)

def visualize_results(history, model, val_ds):
    print("Generating Training Graphs...")
    acc = history.history['cat_accuracy']
    val_acc = history.history['val_cat_accuracy']
    loss = history.history['loss']
    val_loss = history.history['val_loss']
    epochs_range = range(len(acc))

    plt.figure(figsize=(12, 4))

    # Accuracy Plot
    plt.subplot(1, 2, 1)
    plt.plot(epochs_range, acc, label='Training Accuracy')
    plt.plot(epochs_range, val_acc, label='Validation Accuracy')
    plt.legend(loc='lower right')
    plt.title('Training and Validation Accuracy')
    plt.xlabel('Epoch')
    plt.ylabel('Accuracy')

    # Loss Plot
    plt.subplot(1, 2, 2)
    plt.plot(epochs_range, loss, label='Training Loss')
    plt.plot(epochs_range, val_loss, label='Validation Loss')
    plt.legend(loc='upper right')
    plt.title('Training and Validation Loss')
    plt.xlabel('Epoch')
    plt.ylabel('Loss')

    plt.savefig('training_curves.png')
    print("Saved 'training_curves.png'")
    plt.show()
    plt.close()

    print("Evaluating Final Model on Test Set...")
    final_loss, final_acc = model.evaluate(val_ds)
    print(f"--------------------------------------")
    print(f"🏆 FINAL TEST ACCURACY: {final_acc * 100:.2f}%")
    print(f"--------------------------------------")

    y_true = []
    y_pred = []

    for img_batch, label_batch in val_ds.take(20):
        preds = model.predict(img_batch, verbose=0)

        pred_scores = preds[:, 0]
        true_labels = label_batch[:, 0]

        y_pred.extend(np.round(pred_scores))
        y_true.extend(true_labels)

    # Confusion Matrix
    cm = confusion_matrix(y_true, y_pred)

    plt.figure(figsize=(6, 5))
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues',
                xticklabels=['Not Cat', 'Cat'],
                yticklabels=['Not Cat', 'Cat'])
    plt.ylabel('Actual')
    plt.xlabel('Predicted')
    plt.title('Confusion Matrix (Validation Set)')
    plt.savefig('confusion_matrix.png')
    print("Saved 'confusion_matrix.png'")
    plt.show()
    plt.close()

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

    # Metrics Bar Chart
    plt.figure(figsize=(6, 5))
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
    plt.savefig('metrics_summary.png')
    print(f"Metrics visualization saved")
    plt.show()
    plt.close()

def strict_loss(y_true, y_pred):
    true_score = y_true[:, 0:1]
    pred_score = tf.clip_by_value(y_pred[:, 0:1], 1e-7, 1-1e-7)

    pos_loss = -true_score * tf.math.log(pred_score)
    neg_loss = -1.0 * (1 - true_score) * tf.math.log(1 - pred_score)
    score_loss = tf.reduce_mean(pos_loss + neg_loss)

    box_diff = tf.square(y_true[:, 1:] - y_pred[:, 1:])
    box_loss_raw = tf.reduce_mean(box_diff, axis=1)
    masked_box_loss = tf.reduce_mean(box_loss_raw * tf.squeeze(true_score))

    return score_loss + masked_box_loss

if __name__ == "__main__":
    train_ds, val_ds = load_data()
    base_model = create_model()

    num_images = 5000
    end_step = np.ceil(num_images / BATCH_SIZE).astype(np.int32) * EPOCHS

    # Polynomial Decay Pruning
    pruning_params = {
      'pruning_schedule': tfmot.sparsity.keras.PolynomialDecay(
          initial_sparsity=0.00,
          final_sparsity=0.50,
          begin_step=0,
          end_step=end_step
      )
    }
    model = tfmot.sparsity.keras.prune_low_magnitude(base_model, **pruning_params)

    lr_schedule = tf.keras.optimizers.schedules.CosineDecay(
        initial_learning_rate=0.01,
        decay_steps=EPOCHS * 150
    )

    model.compile(
        optimizer=tf.keras.optimizers.Adam(learning_rate=lr_schedule),
        loss=strict_loss,
        metrics=[cat_accuracy]
    )

    # Save best based on val loss
    checkpoint = tf.keras.callbacks.ModelCheckpoint(
        'best_scratch_model.h5',
        save_best_only=True,
        monitor='val_loss',
        mode='min'
    )

    print(f"Training for {EPOCHS} Epochs...")
    history = model.fit(
        train_ds,
        validation_data=val_ds,
        epochs=EPOCHS,
        callbacks=[tfmot.sparsity.keras.UpdatePruningStep(), checkpoint]
    )
    visualize_results(history, model, val_ds)

    print("Converting Best Model...")
    model.load_weights('best_scratch_model.h5')
    final_model = tfmot.sparsity.keras.strip_pruning(model)

    converter = tf.lite.TFLiteConverter.from_keras_model(final_model)
    converter.optimizations = [tf.lite.Optimize.DEFAULT]
    converter.target_spec.supported_ops = [tf.lite.OpsSet.TFLITE_BUILTINS_INT8]
    converter.inference_input_type = tf.int8
    converter.inference_output_type = tf.int8

    def rep_data():
        for batch in train_ds.take(1):
            for img in batch[0]: yield [tf.expand_dims(img, 0)]
    converter.representative_dataset = rep_data

    tflite_model = converter.convert()
    with open('cat_ultimate3.tflite', 'wb') as f: f.write(tflite_model)
    print("DONE.")

visualize_results(history, model, val_ds)