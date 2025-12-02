import tensorflow as tf
import tensorflow_datasets as tfds
from tensorflow.keras import layers, Model, applications
import numpy as np

# --- CONFIG ---
INPUT_SIZE = 128
ALPHA = 0.35
BATCH_SIZE = 32
EPOCHS = 15  # Fewer epochs needed since backbone is frozen

def load_data():
    print("Loading Cats (Oxford Pets)...")
    pets_data, _ = tfds.load('oxford_iiit_pet:4.0.0', with_info=True, split='train')
    
    print("Loading The Universe (Caltech101)...")
    universe_data, _ = tfds.load('caltech101', with_info=True, split='train')
    
    # --- 1. POSITIVES (CATS) ---
    def format_cat(x):
        return x['image'], True, x['segmentation_mask']

    cats = pets_data.filter(lambda x: x['species'] == 0).take(2500)
    cats = cats.map(format_cat)

    # --- 2. NEGATIVES (THE UNIVERSE) ---
    def format_universe(x):
        h = tf.shape(x['image'])[0]
        w = tf.shape(x['image'])[1]
        dummy_mask = tf.zeros((h, w, 1), dtype=tf.uint8)
        return x['image'], False, dummy_mask

    # Use Caltech101 (excluding Leopards/Cougars labels 43, etc if needed, but negligible)
    universe = universe_data.take(2500)
    universe = universe.map(format_universe)
    
    # --- 3. COMBINE ---
    dataset = cats.concatenate(universe)
    dataset = dataset.shuffle(5000)

    # --- HELPERS ---
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
        
        has_pixels = tf.greater(tf.shape(pixels)[0], 0)
        return tf.cond(has_pixels, found, empty), tf.shape(mask)

    def preprocess(image, is_cat, mask):
        img = tf.image.resize(image, (INPUT_SIZE, INPUT_SIZE))
        img = tf.cast(img, tf.float32) / 255.0
        
        # Only get box if it's a cat
        def get_real_box():
             bbox_raw, shape = get_bbox(mask)
             y1, x1, y2, x2 = bbox_raw
             h, w = tf.cast(shape[0], tf.float32), tf.cast(shape[1], tf.float32)
             h = tf.maximum(h, 1.0)
             w = tf.maximum(w, 1.0)
             return tf.stack([y1/h, x1/w, y2/h, x2/w])

        final_box = tf.cond(is_cat, get_real_box, lambda: tf.constant([0.0, 0.0, 0.0, 0.0]))
        score = tf.cast(is_cat, tf.float32)
        
        target = tf.concat([[score], final_box], axis=0)
        return img, target

    ds = dataset.map(preprocess, num_parallel_calls=tf.data.AUTOTUNE)
    ds = ds.batch(BATCH_SIZE).prefetch(tf.data.AUTOTUNE)
    return ds

# --- MODEL WITH FROZEN BACKBONE ---
def create_model():
    # Load ImageNet weights
    base = applications.MobileNetV2(
        input_shape=(128, 128, 3), 
        alpha=ALPHA, 
        include_top=False, 
        weights='imagenet'
    )
    
    # CRITICAL FIX: Freeze the brain!
    # This prevents the model from forgetting what "Not a Cat" looks like.
    base.trainable = False 
    
    x = base.get_layer('block_13_project_BN').output
    x = layers.GlobalAveragePooling2D()(x)
    x = layers.Dropout(0.2)(x) 
    
    # Head must be initialized with random weights, so we give it more capacity to learn
    x = layers.Dense(32, activation='relu')(x) # Intermediate layer
    outputs = layers.Dense(5, activation='sigmoid')(x)
    
    return Model(inputs=base.input, outputs=outputs)

# --- STRICT LOSS ---
def strict_loss(y_true, y_pred):
    true_score = y_true[:, 0:1]
    pred_score = y_pred[:, 0:1]
    true_box = y_true[:, 1:]
    pred_box = y_pred[:, 1:]
    
    epsilon = 1e-7
    pred_score = tf.clip_by_value(pred_score, epsilon, 1.0 - epsilon)
    
    # 1. SCORE LOSS
    pos_loss = -true_score * tf.math.log(pred_score)
    # Heavy penalty for false positives
    neg_loss = -5.0 * (1 - true_score) * tf.math.log(1 - pred_score)
    score_loss = tf.reduce_mean(pos_loss + neg_loss)
    
    # 2. BOX LOSS (Masked)
    box_diff = tf.square(true_box - pred_box)
    box_loss = tf.reduce_mean(box_diff, axis=1) 
    masked_box_loss = tf.reduce_mean(box_loss * tf.squeeze(true_score))
    
    return score_loss + (10.0 * masked_box_loss)

if __name__ == "__main__":
    train_ds = load_data()
    model = create_model()
    model.compile(optimizer='adam', loss=strict_loss)
    
    print("Training Frozen Model (Knowledge Preservation)...")
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
    output_name = 'cat_frozen.tflite'
    with open(output_name, 'wb') as f: f.write(tflite_model)
    print(f"DONE! Saved {output_name}")
    print(f"File Size: {len(tflite_model)/1024:.2f} KB")