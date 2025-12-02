import tensorflow as tf
import tensorflow_datasets as tfds
from tensorflow.keras import layers, Model, applications
import numpy as np

# --- CONFIG ---
INPUT_SIZE = 128
ALPHA = 0.35
BATCH_SIZE = 32
EPOCHS = 20

# --- 1. DATASET WITH NEGATIVES ---
def load_data():
    print("Loading Data (Oxford Pets v4.0.0)...")
    dataset, info = tfds.load('oxford_iiit_pet:4.0.0', with_info=True, split='train+test')
    
    # Helper to extract box
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

        return tf.cond(tf.shape(pixels)[0] > 0, found, empty), tf.shape(mask)

    def preprocess(sample):
        img = tf.image.resize(sample['image'], (INPUT_SIZE, INPUT_SIZE))
        img = tf.cast(img, tf.float32) / 255.0
        
        # Check if it's a cat (Species 0)
        is_cat = tf.equal(sample['species'], 0)
        
        # If Cat: Get Box. If Not Cat (Dog/Background): Box is [0,0,0,0]
        # We rely on TF's 'cond' logic to handle this branching
        
        # Logic: 
        # 1. Get real box if exists
        # 2. If 'species' is NOT cat, overwrite box with zeros and score with 0.
        
        bbox_raw, shape = get_bbox(sample['segmentation_mask'])
        y1, x1, y2, x2 = bbox_raw
        h, w = tf.cast(shape[0], tf.float32), tf.cast(shape[1], tf.float32)
        
        norm_box = tf.stack([y1/h, x1/w, y2/h, x2/w])
        
        # Final Target construction
        # If Cat: Score=1.0, Box=Real
        # If Not Cat: Score=0.0, Box=[0,0,0,0]
        
        score = tf.cast(is_cat, tf.float32) # 1.0 or 0.0
        
        # If not cat, zero out the box
        final_box = tf.cond(is_cat, lambda: norm_box, lambda: tf.constant([0.0, 0.0, 0.0, 0.0]))
        
        target = tf.concat([[score], final_box], axis=0)
        return img, target

    # Instead of filtering ONLY for cats, we take everything!
    # Oxford Pet has 37 categories. ~12 are cats, ~25 are dogs.
    # Dogs will serve as excellent "Hard Negatives" (they look like cats but aren't).
    
    # We map preprocessing
    ds = dataset.map(preprocess, num_parallel_calls=tf.data.AUTOTUNE)
    ds = ds.batch(BATCH_SIZE).prefetch(tf.data.AUTOTUNE)
    return ds

# --- 2. MODEL (Unchanged) ---
def create_model():
    base = applications.MobileNetV2(input_shape=(128, 128, 3), alpha=ALPHA, include_top=False)
    x = base.get_layer('block_13_project_BN').output
    x = layers.GlobalAveragePooling2D()(x)
    x = layers.Dropout(0.2)(x)
    outputs = layers.Dense(5, activation='sigmoid')(x)
    return Model(inputs=base.input, outputs=outputs)

# --- 3. LOSS (Unchanged) ---
def robust_custom_loss(y_true, y_pred):
    true_score = y_true[:, 0:1]
    pred_score = y_pred[:, 0:1]
    true_box = y_true[:, 1:]
    pred_box = y_pred[:, 1:]
    
    epsilon = 1e-7
    pred_score = tf.clip_by_value(pred_score, epsilon, 1.0 - epsilon)
    score_loss = -tf.reduce_mean(true_score * tf.math.log(pred_score) + (1 - true_score) * tf.math.log(1 - pred_score))
    
    # Only calculate box loss if the image actually HAS a cat
    # We multiply box_loss by 'true_score' so background images don't confuse the regression
    box_loss_raw = tf.reduce_mean(tf.square(true_box - pred_box), axis=1)
    box_loss = tf.reduce_mean(box_loss_raw * tf.squeeze(true_score)) 
    
    return score_loss + (10.0 * box_loss)

# --- 4. TRAIN ---
if __name__ == "__main__":
    train_ds = load_data()
    model = create_model()
    model.compile(optimizer='adam', loss=robust_custom_loss)
    
    print("Training on Cats AND Dogs (as negatives)...")
    model.fit(train_ds, epochs=EPOCHS)
    
    print("Quantizing...")
    converter = tf.lite.TFLiteConverter.from_keras_model(model)
    converter.optimizations = [tf.lite.Optimize.DEFAULT]
    converter.target_spec.supported_ops = [tf.lite.OpsSet.TFLITE_BUILTINS_INT8]
    converter.inference_input_type = tf.int8
    converter.inference_output_type = tf.int8
    
    def rep_data():
        for batch in train_ds.take(1):
            for img in batch[0]: yield [tf.expand_dims(img, 0)]
    converter.representative_dataset = rep_data
    
    tflite_model = converter.convert()
    with open('cat_single_shot.tflite', 'wb') as f: f.write(tflite_model)
    print(f"DONE! Size: {len(tflite_model)/1024:.2f} KB")