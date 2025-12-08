# AFTAC-DL

A comprehensive deep learning project for battery state-of-health (SOH) monitoring and object detection, featuring embedded deployment on STM32 microcontrollers with real-time visualization.

## Table of Contents
- [Overview](#overview)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Components](#components)
  - [State of Health Model](#state-of-health-model)
  - [Object Detection Model](#object-detection-model)
  - [Web Dashboard](#web-dashboard)
  - [STM32 Embedded System](#stm32-embedded-system)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Development](#development)

## Overview

This repository contains a capstone project integrating machine learning models for battery health monitoring and object detection, optimized for edge deployment on STM32F746 microcontrollers. The system features:

- **State-of-Health (SOH) Prediction**: CNN-based time series model for battery health monitoring
- **Object Detection**: Optimized neural network for real-time object detection
- **Interactive Dashboard**: React-based web interface for data visualization and model inference
- **Embedded Deployment**: STM32 integration with model quantization and optimization

## Quick Start

### Python Environment Setup

1. Create a Python virtual environment:
   ```bash
   python3 -m venv .venv
   ```

2. Activate the virtual environment:
   - **Linux/Mac**: `source .venv/bin/activate`
   - **Windows**: `.venv\Scripts\activate`

3. Install Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```

**Note**: Tested with Python 3.10/3.11. TensorFlow and ONNX versions are sensitive—use the exact versions specified in `requirements.txt`.

### Dashboard Setup

```bash
cd dashboard
npm install
npm run dev
```

## Project Structure

```
AFTAC-DL/
├── soh-model/              # State-of-Health prediction model
├── od-model/               # Object detection model
├── dashboard/              # Web-based visualization dashboard
├── STM32F746/             # STM32 embedded system code
├── requirements.txt        # Python dependencies
└── README.md
```

## Components

### State of Health Model

**Location**: `soh-model/`

CNN-based time series model for predicting battery state-of-health from sensor data.

**Key Features**:
- Temporal convolutional neural network architecture
- Synthetic data generation for training
- Model pruning and quantization for edge deployment
- ONNX export for cross-platform inference

**Files**:
- `cnn_pytorch.py` - Hyperparameter tuning with Bayesian Optimization
- `cnn_prune.py` / `cnn_prune.ipynb` - Full Model Pipeline (train, prune, quantize, evaluate)
- `cnn_preprocessor.py` - Data preprocessing utilities
- `config.json` - Model hyperparameters:
  ```json
  {
    "SEQUENCE_LENGTH": 48,
    "STEP_SIZE": 24,
    "FORECAST_HORIZON": 1,
    "BATCH_SIZE": 32,
    "NUM_EPOCHS": 10
  }
  ```
- `data/` - Training data and synthetic data generation scripts
- `saved-model/` - Exported ONNX and TFLite models

**Alternative Models**: `other-models/` contains LSTM, TCN, and experimental architectures.

### Object Detection Model

**Location**: `od-model/`

Optimized neural network for object detection with Bayesian hyperparameter optimization.

**Key Files**:
- `od-model.ipynb` - Main object detection model notebook
- `bayesianOptimization.ipynb` / `bayesianOptimizationTorch.ipynb` - Hyperparameter tuning
- `quantization.ipynb` - Model quantization for deployment
- `best_bayesian_model.h5` - Trained Keras model
- `final_best.pt` - PyTorch model checkpoint
- `pruned_final_best.onnx` - Optimized ONNX export

**Workflow**:
1. Train model using Bayesian optimization
2. Prune and quantize for edge deployment
3. Convert to ONNX format
4. Deploy to dashboard/STM32

### Web Dashboard

**Location**: `dashboard/`

React + TypeScript web application for real-time visualization and model inference.

**Features**:
- Battery health metrics visualization with Recharts
- Real-time ONNX model inference in browser
- CSV data import and processing
- Interactive charts and analytics

**Tech Stack**:
- React 19
- TypeScript
- Vite (build tool)
- ONNX Runtime Web
- Recharts (data visualization)
- Lucide React (icons)

**Key Files**:
- `src/HealthDashboard.tsx` - Main SOH dashboard component
- `src/ObjectDetection.tsx` - Object detection interface
- `src/ModelMetrics.tsx` - Model performance metrics
- `runInference.py` - Python inference utilities
- `convertCSV.py` / `convertToCSV.py` - Data conversion scripts
- `public/assets/` - Model files and datasets

**Development**:
```bash
cd dashboard
npm install
npm run dev        # Development server
npm run build      # Production build
npm run preview    # Preview production build
```

**Dependencies** (key):
- `onnxruntime-web`: Browser-based model inference
- `recharts`: Data visualization
- `npyjs`: NumPy file parsing in JavaScript

### STM32 Embedded System

**Location**: `STM32F746/`

Uses the STM32F746 Discovery board firmware for embedded ML inference using X-CUBE-AI on renode simulations.

**Build System**:
- CMake-based build configuration
- GCC ARM toolchain support
- Renode simulation support (`stm32.resc`)

**Key Files**:
- `STM32F746.ioc` - CubeMX configuration
- `CMakeLists.txt` - Build configuration
- `Core/src/main.c` - Application code
- `X-CUBE-AI/App/` - AI model integration
- `Middlewares/` - FreeRTOS, FATFS, USB

**Build Instructions**:
```bash
cd STM32F746
cmake --preset=default
cmake --build config_default
```

**Simulation**:
```bash
renode stm32.resc
```

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/adharshr15/AFTAC-DL.git
   cd AFTAC-DL
   ```

2. **Set up Python environment**:
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate  # Linux/Mac
   pip install -r requirements.txt
   ```

3. **Set up dashboard**:
   ```bash
   cd dashboard
   npm install
   ```

4. **Configure STM32 (optional)**:
   - Install STM32CubeIDE or ARM toolchain
   - Follow build instructions in STM32 section

## Usage

### Training Models

**SOH Model**:
```bash
cd soh-model
python cnn_preprocessor.py
python cnn_prune.py
```

**Object Detection**:
```bash
cd od-model
jupyter notebook od-model.ipynb
```

### Running Dashboard

```bash
cd dashboard
npm run dev
```
Access at `http://localhost:5173`

### Model Inference

**Python**:
```bash
cd dashboard
python runInference.py
```

**Browser** (automatic via ONNX Runtime Web in dashboard)

## Development

### Model Development Workflow

1. **Train**: Use PyTorch/TensorFlow in respective notebooks
2. **Optimize**: Apply pruning and quantization
3. **Convert**: Export to ONNX format
4. **Test**: Validate in Python with ONNX Runtime
5. **Deploy**: 
   - Copy to `dashboard/public/assets/` for web
   - Convert to C arrays for STM32 using X-CUBE-AI

### Data Pipeline

1. Generate synthetic data: `soh-model/data/Final_SynData_Gen.py`
2. Preprocess: `soh-model/cnn_preprocessor.py`
3. Convert formats: `dashboard/convertCSV.py`
4. Load in dashboard for visualization

## License

See `STM32F746/LICENSE_X-CUBE-AI.txt` for X-CUBE-AI licensing.

---

**Course**: 482 Capstone Project  
**Repository**: [adharshr15/AFTAC-DL](https://github.com/adharshr15/AFTAC-DL)
