import { SensorData } from './types';
import { readFile } from "fs/promises";

// Extended the user provided CSV with synthetic data to demonstrate the simulation better
// Now includes Machine 1 (Failure Scenario), Machine 2 (Healthy), and Machine 3 (Warning/High Vibration)
export const RAW_CSV_DATA = await loadCsv();
console.log(RAW_CSV_DATA);


export async function loadCsv() {
  const res = await fetch("assets/synthetic_data_independent_failures_4_gb_timestamp.csv");
  const text = await res.text();
  return text;
}


export const parseCSV = (csv: string): SensorData[] => {
  const lines = csv.trim().split('\n');
  const headers = lines[0].split(',');
  
  return lines.slice(1).map(line => {
    const values = line.split(',');
    return {
      machine_id: parseInt(values[0]),
      timestamp: values[1],
      T_internal_sensor: parseFloat(values[2]),
      V_sensor: parseFloat(values[3]),
      failure_mode: parseInt(values[4]),
      is_precursor_period: parseInt(values[5]),
      is_final_failure: parseInt(values[6]),
    };
  });
};

export const METRICS_DATA = [
  {
    metric: "Accuracy",
    baseline: ">90%",
    optimized: ">90%",
    improvement: "Maintained",
    detail: "Classification accuracy preserved despite pruning."
  },
  {
    metric: "Latency",
    baseline: "N/A",
    optimized: "10 ms",
    improvement: "Ultra-low",
    detail: "Inference speed on Raspberry Pi 4."
  },
  {
    metric: "Memory Footprint",
    baseline: "~50 MB",
    optimized: "256 KB",
    improvement: "99.5% Reduction",
    detail: "Fits within microcontroller SRAM limits."
  },
  {
    metric: "Power Consumption",
    baseline: "5 W",
    optimized: "1 mW",
    improvement: "5000x Efficiency",
    detail: "Estimated power draw for quantized model."
  }
];

export const DETECTION_LOGS = [
  { id: 101, time: "09:42:15 AM", object: "Person", confidence: "98%" },
  { id: 102, time: "09:45:30 AM", object: "Hard Hat", confidence: "94%" },
  { id: 103, time: "10:12:05 AM", object: "Forklift", confidence: "91%" },
  { id: 104, time: "10:15:22 AM", object: "Person", confidence: "99%" },
  { id: 105, time: "10:30:00 AM", object: "Package", confidence: "88%" },
];