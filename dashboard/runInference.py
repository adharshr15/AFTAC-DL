from fastapi import FastAPI
import onnxruntime as ort
import numpy as np

app = FastAPI()

session = ort.InferenceSession("public/assets/temperature.onnx")
input_name = session.get_inputs()[0].name

@app.post("/predict")
def predict(values: list[float]):
    arr = np.array(values, dtype=np.float32).reshape(1, 24)
    outputs = session.run(None, {input_name: arr})
    return {"prediction": outputs[0].tolist()}
