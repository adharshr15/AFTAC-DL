import { SensorData } from './types';
import { readFile } from "fs/promises";

// Extended the user provided CSV with synthetic data to demonstrate the simulation better
// Now includes Machine 1 (Failure Scenario), Machine 2 (Healthy), and Machine 3 (Warning/High Vibration)
export const RAW_CSV_DATA = await loadCsv();
console.log(RAW_CSV_DATA);


export async function loadCsv() {
  const res = await fetch("assets/synthetic_data_from_npy.csv");
  const text = await res.text();
  return text;
}


export const parseCSV = (csv: string): (SensorData & { T_internal_sequence: number[] })[] => {
  const lines = csv.trim().split('\n');

  // Remove header
  const dataLines = lines.slice(1);

  return dataLines.map(line => {
    // Use regex to split CSV respecting quotes
    const values = line.match(/(".*?"|[^",\s]+)(?=\s*,|\s*$)/g);

    if (!values || values.length < 8) {
      throw new Error(`Invalid CSV line: ${line}`);
    }

    // Parse sequence
    let sequence: number[] = [];
    const seqString = values[7].replace(/^\[|\]$/g, '').replace(/"/g, '');
    if (seqString) {
      sequence = seqString
        .split(',')
        .map(v => parseFloat(v.trim()))
        .filter(v => !isNaN(v));
    }

    return {
      machine_id: parseInt(values[0]),
      timestamp: values[1],
      T_internal_sensor: parseFloat(values[2]),
      V_sensor: parseFloat(values[3]),
      failure_mode: parseInt(values[4]),
      is_precursor_period: parseInt(values[5]),
      is_final_failure: parseInt(values[6]),
      T_internal_sequence: sequence,
    };
  });
};




export const METRICS_DATA = [
  {
    metric: "Accuracy (Object Detection)",
    baseline: ">70%",
    optimized: "92.81%",
    improvement: "Improved",
    detail: "Overall classification accuracy with current model."
  },
  {
    metric: "R^2 (State of Health)",
    baseline: ">70%",
    optimized: "0.8618",
    improvement: "Maintained",
    detail: "Original Model MSE: 0.0268"
  },
  {
    metric: "mAP (IoU = 0.5) (Object Detection)",
    baseline: "N/A",
    optimized: "96.40%",
    improvement: "High",
    detail: "Proportion of correctly detected objects among all predicted positives."
  },
  {
    metric: "Total Ram Memory (State of Health)",
    baseline: "N/A",
    optimized: "239,048 B",
    improvement: "High",
    detail: "Drastically reduced"
  },
];

export const DETECTION_LOGS = [
  { id: 101, time: "09:42:15 AM", object: "Person", confidence: "98%" },
  { id: 102, time: "09:45:30 AM", object: "Hard Hat", confidence: "94%" },
  { id: 103, time: "10:12:05 AM", object: "Forklift", confidence: "91%" },
  { id: 104, time: "10:15:22 AM", object: "Person", confidence: "99%" },
  { id: 105, time: "10:30:00 AM", object: "Package", confidence: "88%" },
];