import tensorflow as tf

interpreter = tf.lite.Interpreter(model_path="pruned_quantized_model.tflite")
interpreter.allocate_tensors()

for i, op in enumerate(interpreter._get_ops_details()):
    print(i, op["op_name"])
