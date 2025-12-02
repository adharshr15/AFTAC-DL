import tensorflow as tf
import tensorflow_datasets as tfds
from tensorflow.keras import layers, Model, applications
import numpy as np

# --- CONFIG ---
INPUT_SIZE = 128
ALPHA = 0.35
BATCH_SIZE = 32
EPOCHS = 20  # You can increase to 30 for even better accuracy

def load_balanced_data():
    print("Loading Data (Oxford Pets v4.0.0)...")
    dataset, info = tfds.load('oxford_iiit_pet:4.0.0', with_info=True, split='train+test')
    
    # --- 1. FORCE 50/50 BALANCE ---
    cats = dataset.filter(lambda x: x['species'] == 0)
    dogs = dataset.filter(lambda x: x['species'] != 0)
    
    # Take 2300 of each (approx size of cat dataset)
    # This prevents the "Lazy Guessing" problem
    dogs = dogs.take(2300) 
    
    # Combine and Shuffle
    dataset = cats.concatenate(dogs)
    dataset = dataset.shuffle(5000)

    # --- 2. PREPROCESSING ---
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
        
        is_cat = tf.equal(sample['species'], 0)
        
        bbox_raw, shape = get_bbox(sample['segmentation_mask'])
        y1, x1, y2, x2 = bbox_raw
        h, w = tf.cast(shape[0], tf.float32), tf.cast(shape[1], tf.float32)
        
        norm_box = tf.stack([y1/h, x1/w, y2/h, x2/w])
        
        # Target: [Score, y1, x1, y2, x2]
        score = tf.cast(is_cat, tf.float32)
        final_box = tf.cond(is_cat, lambda: norm_box, lambda: tf.constant([0.0, 0.0, 0.0, 0.0]))
        
        target = tf.concat([[score], final_box], axis=0)
        return img, target

    ds = dataset.map(preprocess, num_parallel_calls=tf.data.AUTOTUNE)
    ds = ds.batch(BATCH_SIZE).prefetch(tf.data.AUTOTUNE)
    return ds

def create_model():
    base = applications.MobileNetV2(input_shape=(128, 128, 3), alpha=ALPHA, include_top=False)
    # Cut Tail at Block 13 (8x8) to keep size ~230KB
    x = base.get_layer('block_13_project_BN').output
    x = layers.GlobalAveragePooling2D()(x)
    x = layers.Dropout(0.2)(x) 
    outputs = layers.Dense(5, activation='sigmoid')(x)
    return Model(inputs=base.input, outputs=outputs)

# --- THE "GHOST BUSTER" LOSS FUNCTION ---
def hard_negative_loss(y_true, y_pred):
    true_score = y_true[:, 0:1]
    pred_score = y_pred[:, 0:1]
    true_box = y_true[:, 1:]
    pred_box = y_pred[:, 1:]
    
    epsilon = 1e-7
    pred_score = tf.clip_by_value(pred_score, epsilon, 1.0 - epsilon)
    
    # 1. POSITIVE LOSS (It is a cat)
    pos_loss = -true_score * tf.math.log(pred_score)
    
    # 2. NEGATIVE LOSS (It is NOT a cat)
    # **WEIGHTED 5.0x** -> This is the fix.
    # It tells the model: "Guessing 'Cat' on an empty room is 5x worse than missing a real cat."
    neg_loss = -5.0 * (1 - true_score) * tf.math.log(1 - pred_score)
    
    score_loss = tf.reduce_mean(pos_loss + neg_loss)
    
    # 3. BOX LOSS (Only correct box if it IS a cat)
    box_loss_raw = tf.reduce_mean(tf.square(true_box - pred_box), axis=1)
    box_loss = tf.reduce_mean(box_loss_raw * tf.squeeze(true_score)) 
    
    return score_loss + (10.0 * box_loss)

if __name__ == "__main__":
    train_ds = load_balanced_data()
    model = create_model()
    model.compile(optimizer='adam', loss=hard_negative_loss)
    
    print("Training Final Model (With Hard Negative Mining)...")
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
    output_name = 'cat_final_v2.tflite'
    with open(output_name, 'wb') as f: f.write(tflite_model)
    print(f"DONE! Saved {output_name}")
    print(f"Final Size: {len(tflite_model)/1024:.2f} KB")