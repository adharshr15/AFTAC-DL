import sys

data = open("pruned_quantized_model.tflite", "rb").read()
with open("model_data.cc", "w") as f:
    f.write("unsigned char model_tflite[] = {")
    for i, b in enumerate(data):
        if i % 12 == 0:
            f.write("\n  ")
        f.write(f"0x{b:02x}, ")
    f.write("\n};\n")
    f.write(f"unsigned int model_tflite_len = {len(data)};\n")
