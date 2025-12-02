export interface SensorData {
  machine_id: number;
  timestamp: string;
  T_internal_sensor: number;
  V_sensor: number;
  failure_mode: number;
  is_precursor_period: number;
  is_final_failure: number;
}

export enum Tab {
  HEALTH_MONITOR = 'HEALTH_MONITOR',
  OBJECT_DETECTION = 'OBJECT_DETECTION',
  MODEL_METRICS = 'MODEL_METRICS',
}

export interface MachineStatus {
  id: number;
  name: string;
  status: 'Healthy' | 'Warning' | 'Critical';
  lastUpdate: string;
}