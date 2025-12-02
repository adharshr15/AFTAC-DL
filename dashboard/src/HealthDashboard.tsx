import React, { useState, useEffect, useMemo, useRef } from 'react';
import { 
  LineChart, 
  Line, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  Legend, 
  ResponsiveContainer,
  ReferenceLine
} from 'recharts';
import * as ort from 'onnxruntime-web';

import { Play, RotateCcw, Activity, Thermometer, Zap, AlertTriangle, CheckCircle, XCircle, Monitor, Upload, BrainCircuit, FileCode } from 'lucide-react';
import { RAW_CSV_DATA, parseCSV } from '../constants';
import { SensorData } from '../types';

// Configure onnxruntime to use wasm path correctly if needed in standard bundlers
ort.env.wasm.wasmPaths = "https://cdn.jsdelivr.net/npm/onnxruntime-web/dist/";
console.log("WASM paths:", ort.env.wasm.wasmPaths);


const HealthDashboard: React.FC = () => {
  // Start with default data, but allow user to override it
  const [dataSource, setDataSource] = useState<SensorData[]>(() => parseCSV(RAW_CSV_DATA));
  const [streamedData, setStreamedData] = useState<any[]>([]); 
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isPlaying, setIsPlaying] = useState(false);
  const [selectedMachineId, setSelectedMachineId] = useState<number>(1);
  const [session, setSession] = useState<ort.InferenceSession | null>(null);
  
  // Buffers to store the last 24 data points for each machine
  const machineHistoryRef = useRef<Record<number, number[]>>({});

  const fileInputRef = useRef<HTMLInputElement>(null);

  // Get unique machine IDs from the current data source
  const machineIds = useMemo(() => {
    return Array.from(new Set(dataSource.map(d => d.machine_id))).sort((a: number, b: number) => a - b);
  }, [dataSource]);

  // Ensure selectedMachineId is valid when data changes
  useEffect(() => {
    if (!machineIds.includes(selectedMachineId) && machineIds.length > 0) {
      setSelectedMachineId(machineIds[0]);
    }
  }, [machineIds, selectedMachineId]);

  // --- Load ONNX Model ---
  useEffect(() => {
    const loadModel = async () => {
      try {
        // Path matches the structure: public/assets/temperature.onnx
        const sess = await ort.InferenceSession.create('/assets/temperature.onnx', {
          executionProviders: ['wasm'], 
        });
        setSession(sess);
        console.log("ONNX Model (Temperature) loaded successfully");
      } catch (e) {
        console.warn("Could not load ONNX model, falling back to simulation.", e);
      }
    };
    loadModel();
  }, []);

// Queue helper to serialize all session.run() calls
const runSessionQueue = (() => {
  let queue: Promise<any> = Promise.resolve();
  return (fn: () => Promise<any>) => {
    queue = queue.then(() => fn());
    return queue;
  };
})();

const predictTemperature = async (
  machineId: number,
  actualTemp: number
): Promise<{
  predictedTemp: number;
  status: 'Healthy' | 'Unhealthy';
  confidence: number;
}> => {
  // Initialize buffer if it doesn't exist
  if (!machineHistoryRef.current[machineId]) {
    machineHistoryRef.current[machineId] = [];
  }

  const history = machineHistoryRef.current[machineId];

  // Need 24 points to make a prediction
  if (history.length < 24) {
    machineHistoryRef.current[machineId] = [...history, actualTemp];
    return { predictedTemp: 0, status: 'Healthy', confidence: 0 }; // Warming up
  }

  let predictedVal = 0;

  if (session) {
    try {
      predictedVal = await runSessionQueue(async () => {
        const inputWindow = history.slice(-24);
        const inputData = Float32Array.from(inputWindow);
        const tensor = new ort.Tensor('float32', inputData, [1, 24, 1]);
        console.log('ONNX Inference Input Tensor:', tensor);
        const feeds: Record<string, ort.Tensor> = {
          [session.inputNames[0]]: tensor,
        };

        const results = await session.run(feeds);
        const outputName = session.outputNames[0];
        const output = results[outputName].data as Float32Array;

        return output[0]; // predicted temperature
      });
      console.log('ONNX Inference: ', {predictedVal})
    } catch (e) {
      console.error('ONNX Inference Error:', e);
      // // Fallback simple linear projection
      // const last = history[history.length - 1];
      // const prev = history[history.length - 2];
      // predictedVal = last + (last - prev);
    }
  } else {
    console.warn("ONNX session not available");
    // Fallback simulation
    // const inputWindow = history.slice(-24);
    // const sum = inputWindow.reduce((a, b) => a + b, 0);
    // const avg = sum / inputWindow.length;
    // const trend = inputWindow[23] - inputWindow[20];
    // predictedVal = avg + trend;
  }

  // Update history with current temperature
  const newHistory = [...history, actualTemp];
  if (newHistory.length > 24) newHistory.shift();
  machineHistoryRef.current[machineId] = newHistory;

  // Anomaly detection
  const deviation = Math.abs(actualTemp - predictedVal);
  const isUnhealthy = deviation > 5.0;
  const confidence = Math.max(0, 100 - deviation * 10);

  console.log('Actual:', {actualTemp});

  return {
    predictedTemp: parseFloat(predictedVal.toFixed(2)),
    status: isUnhealthy ? 'Unhealthy' : 'Healthy',
    confidence: parseFloat(confidence.toFixed(1)),
  };
};



  // Simulation Tick
 useEffect(() => {
  let interval: number | undefined;

  const BATCH_SIZE = 4; // Number of rows to process per tick
  const TICK_MS = 500; // Interval in milliseconds (adjust for speed)

  if (isPlaying && currentIndex < dataSource.length) {
    interval = window.setInterval(async () => {
      const nextBatch = dataSource.slice(currentIndex, currentIndex + BATCH_SIZE);

      if (nextBatch.length > 0) {
        const promises = nextBatch.map(async (row) => {
          const result = await predictTemperature(row.machine_id, row.T_internal_sensor);
          return {
            ...row,
            predicted_temp: result.predictedTemp,
            cnn_status: result.status,
            cnn_confidence: result.confidence,
            is_warming_up: machineHistoryRef.current[row.machine_id]?.length < 24
          };
        });

        const processedBatch = await Promise.all(promises);

        setStreamedData(prev => [...prev, ...processedBatch]);
        setCurrentIndex(prev => prev + nextBatch.length);
      } else {
        setIsPlaying(false);
      }
    }, TICK_MS);
  }

  return () => clearInterval(interval);
}, [isPlaying, currentIndex, dataSource, session]);


  const handleReset = () => {
    setIsPlaying(false);
    setStreamedData([]);
    setCurrentIndex(0);
    machineHistoryRef.current = {}; // Reset buffers
  };

  const handleFileUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        const text = e.target?.result as string;
        try {
          const newData = parseCSV(text);
          if (newData.length > 0) {
            handleReset();
            setDataSource(newData);
            if (newData[0]?.machine_id) {
              setSelectedMachineId(newData[0].machine_id);
            }
            alert(`Successfully loaded ${newData.length} rows of data.`);
          } else {
            alert("CSV parsed but found no data. Check format.");
          }
        } catch (error) {
          console.error(error);
          alert("Error parsing CSV. Ensure it matches the required format.");
        }
      };
      reader.readAsText(file);
    }
  };

  const getMachineLatestState = (id: number) => {
    const machineData = streamedData.filter(d => d.machine_id === id);
    if (machineData.length === 0) {
      return { status: 'Unknown', temp: 0, predicted: 0, vib: 0, timestamp: '--', confidence: 0, warming: true };
    }
    const latest = machineData[machineData.length - 1];
    return {
      status: latest.cnn_status,
      temp: latest.T_internal_sensor,
      predicted: latest.predicted_temp,
      vib: latest.V_sensor,
      timestamp: latest.timestamp,
      confidence: latest.cnn_confidence,
      warming: latest.is_warming_up
    };
  };

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'Healthy': return <CheckCircle className="w-5 h-5 text-green-600" />;
      case 'Unhealthy': return <AlertTriangle className="w-5 h-5 text-red-600 animate-pulse" />;
      default: return <Activity className="w-5 h-5 text-gray-400" />;
    }
  };

  const selectedMachineData = streamedData.filter(d => d.machine_id === selectedMachineId);
  const selectedMachineCurrent = getMachineLatestState(selectedMachineId);

  return (
    <div className="space-y-6 animate-fade-in pb-10">
      {/* Header & Controls */}
      <div className="flex flex-col xl:flex-row justify-between items-start xl:items-center gap-4 bg-white p-4 rounded-xl shadow-sm border border-slate-200">
        <div>
          <h2 className="text-2xl font-bold text-slate-800">State of Health Monitoring</h2>
          <div className="flex items-center gap-2 mt-1">
             <p className="text-slate-500 text-sm">Real-time Forecast (Window: 24)</p>
             {session ? (
               <span className="flex items-center gap-1 text-xs font-medium text-green-600 bg-green-50 px-2 py-0.5 rounded border border-green-200">
                 <FileCode className="w-3 h-3" /> ONNX Loaded
               </span>
             ) : (
               <span className="flex items-center gap-1 text-xs font-medium text-amber-600 bg-amber-50 px-2 py-0.5 rounded border border-amber-200">
                 <Activity className="w-3 h-3" /> Simulated
               </span>
             )}
          </div>
        </div>
        
        <div className="flex flex-wrap items-center gap-3">
          <input 
            type="file" 
            accept=".csv" 
            ref={fileInputRef} 
            onChange={handleFileUpload} 
            className="hidden" 
          />
          <button 
            onClick={() => fileInputRef.current?.click()}
            className="flex items-center gap-2 px-4 py-2 bg-white text-slate-700 rounded-lg hover:bg-slate-50 transition-colors font-medium border border-slate-300"
          >
            <Upload className="w-4 h-4" />
            Upload CSV
          </button>

          <div className="h-6 w-px bg-slate-300 mx-2 hidden md:block"></div>

          <button 
            onClick={() => setIsPlaying(!isPlaying)}
            disabled={currentIndex >= dataSource.length || dataSource.length === 0}
            className={`flex items-center gap-2 px-4 py-2 rounded-lg font-medium transition-colors shadow-sm ${
              isPlaying 
                ? 'bg-amber-100 text-amber-700 hover:bg-amber-200 border border-amber-200' 
                : 'bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed border border-blue-600'
            }`}
          >
            {isPlaying ? 'Pause Forecasting' : 'Start Forecasting'}
            <BrainCircuit className={`w-4 h-4 ${isPlaying ? 'hidden' : 'block'}`} />
            <span className={`${isPlaying ? 'block' : 'hidden'} w-2 h-2 bg-amber-500 rounded-full animate-pulse`} />
          </button>
          
          <button 
            onClick={handleReset}
            className="flex items-center gap-2 px-4 py-2 bg-slate-100 text-slate-700 rounded-lg hover:bg-slate-200 transition-colors font-medium border border-slate-200"
          >
            <RotateCcw className="w-4 h-4" />
            Reset
          </button>
        </div>
      </div>

      {/* Machine Nodes Grid */}
      <div>
        <h3 className="text-lg font-semibold text-slate-800 mb-4 flex items-center gap-2">
          <Monitor className="w-5 h-5 text-slate-500" />
          Connected Machines ({machineIds.length})
        </h3>
        
        {machineIds.length === 0 ? (
          <div className="text-center p-12 border-2 border-dashed border-slate-300 rounded-xl bg-slate-50">
            <p className="text-slate-500">No machine data found. Upload a CSV file to begin forecasting.</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-4">
            {machineIds.map((id) => {
              const info = getMachineLatestState(id);
              const isSelected = selectedMachineId === id;
              const isUnhealthy = info.status === 'Unhealthy';
              
              return (
                <button
                  key={id}
                  onClick={() => setSelectedMachineId(id)}
                  className={`relative p-4 rounded-xl border-2 transition-all duration-200 text-left hover:shadow-md bg-white ${
                    isSelected ? 'ring-2 ring-blue-500 border-blue-500 z-10' : 'border-slate-200 hover:border-blue-300'
                  }`}
                >
                  <div className="flex justify-between items-start mb-3">
                    <div className="bg-slate-100 px-2 py-1 rounded text-xs font-bold uppercase tracking-wider text-slate-600">
                      ID: {id}
                    </div>
                    {info.warming ? (
                      <span className="text-[10px] text-slate-400 font-mono">Initializing...</span>
                    ) : (
                       getStatusIcon(info.status)
                    )}
                  </div>
                  
                  <div className="mb-4">
                     <p className="text-xs text-slate-400 uppercase tracking-wide font-semibold mb-1">
                       Forecast
                     </p>
                     <div className={`flex items-center gap-2 font-bold ${isUnhealthy ? 'text-red-600' : 'text-green-600'}`}>
                        {info.warming ? 'Gathering Data...' : `${info.predicted}°C`}
                     </div>
                  </div>

                  <div className="space-y-2">
                    <div className="flex items-center justify-between p-2 bg-slate-50 rounded">
                      <div className="flex items-center gap-1.5 text-sm text-slate-500">
                        <Thermometer className="w-4 h-4" />
                        <span>Actual</span>
                      </div>
                      <span className="font-mono font-bold text-slate-800">{info.temp.toFixed(1)}°C</span>
                    </div>
                    <div className="flex items-center justify-between p-2 bg-slate-50 rounded">
                      <div className="flex items-center gap-1.5 text-sm text-slate-500">
                        <Zap className="w-4 h-4" />
                        <span>Vib</span>
                      </div>
                      <span className="font-mono font-bold text-slate-800">{info.vib.toFixed(2)}Hz</span>
                    </div>
                  </div>

                  {isUnhealthy && (
                     <div className="absolute inset-0 border-2 border-red-500 rounded-xl animate-pulse pointer-events-none shadow-[0_0_15px_rgba(239,68,68,0.3)]" />
                  )}
                </button>
              );
            })}
          </div>
        )}
      </div>

      {/* Detailed View for Selected Machine */}
      {selectedMachineId && machineIds.includes(selectedMachineId) && (
        <div className="border-t border-slate-200 pt-8 mt-8">
          <div className="flex items-center justify-between mb-6">
             <div className="flex items-center gap-4">
               <div className="bg-blue-100 p-3 rounded-lg">
                 <BrainCircuit className="w-6 h-6 text-blue-600" />
               </div>
               <div>
                 <h3 className="text-xl font-bold text-slate-800">Machine #{selectedMachineId} Forecast</h3>
                 <p className="text-sm text-slate-500">Predicted Temperature vs Actual (Window: 24)</p>
               </div>
             </div>
             
             <div className={`px-4 py-2 rounded-full text-sm font-bold border flex items-center gap-2 shadow-sm ${
               selectedMachineCurrent.status === 'Healthy' ? 'bg-green-50 text-green-700 border-green-200' :
               selectedMachineCurrent.status === 'Unhealthy' ? 'bg-red-50 text-red-700 border-red-200' :
               'bg-gray-50 text-gray-700 border-gray-200'
             }`}>
               {getStatusIcon(selectedMachineCurrent.status)}
               {selectedMachineCurrent.warming ? 'INITIALIZING' : selectedMachineCurrent.status.toUpperCase()}
             </div>
          </div>

          <div className="grid grid-cols-1 xl:grid-cols-2 gap-6">
            {/* Temperature Chart */}
            <div className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm">
              <h3 className="text-lg font-semibold text-slate-800 mb-4 flex items-center gap-2">
                <Thermometer className="w-5 h-5 text-blue-500" />
                Actual vs Predicted Temperature
              </h3>
              <div className="h-[300px] w-full">
                {selectedMachineData.length > 0 ? (
                  <ResponsiveContainer width="100%" height="100%">
                    <LineChart data={selectedMachineData}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#f1f5f9" vertical={false} />
                      <XAxis 
                        dataKey="timestamp" 
                        tick={{fontSize: 10, fill: '#64748b'}} 
                        tickFormatter={(val) => val ? val.split(' ')[1] : ''} 
                        interval="preserveStartEnd"
                        minTickGap={30}
                      />
                      <YAxis 
                        domain={['auto', 'auto']} 
                        tick={{fontSize: 10, fill: '#64748b'}}
                        width={40}
                      />
                      <Tooltip 
                        contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                      />
                      <Legend />
                      <Line 
                        type="monotone" 
                        dataKey="T_internal_sensor" 
                        name="Actual Temp" 
                        stroke="#3b82f6" 
                        strokeWidth={2} 
                        dot={false} 
                        activeDot={{ r: 6 }} 
                        isAnimationActive={false}
                      />
                      <Line 
                        type="monotone" 
                        dataKey="predicted_temp" 
                        name="Predicted Temp" 
                        stroke="#8b5cf6" 
                        strokeWidth={2} 
                        strokeDasharray="5 5"
                        dot={false} 
                        isAnimationActive={false}
                      />
                    </LineChart>
                  </ResponsiveContainer>
                ) : (
                  <div className="h-full flex items-center justify-center text-slate-400 bg-slate-50 rounded-lg">
                    Waiting for forecast data...
                  </div>
                )}
              </div>
            </div>

            {/* Vibration Chart */}
            <div className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm">
              <h3 className="text-lg font-semibold text-slate-800 mb-4 flex items-center gap-2">
                <Zap className="w-5 h-5 text-purple-500" />
                Vibration Analysis
              </h3>
              <div className="h-[300px] w-full">
                {selectedMachineData.length > 0 ? (
                  <ResponsiveContainer width="100%" height="100%">
                    <LineChart data={selectedMachineData}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#f1f5f9" vertical={false} />
                      <XAxis 
                        dataKey="timestamp" 
                        tick={{fontSize: 10, fill: '#64748b'}} 
                        tickFormatter={(val) => val ? val.split(' ')[1] : ''}
                        interval="preserveStartEnd"
                        minTickGap={30}
                      />
                      <YAxis 
                        domain={['auto', 'auto']} 
                        tick={{fontSize: 10, fill: '#64748b'}}
                        width={40}
                      />
                      <Tooltip 
                        contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                      />
                      <Legend />
                      <Line 
                        type="monotone" 
                        dataKey="V_sensor" 
                        name="Vibration (Hz)" 
                        stroke="#f59e0b" 
                        strokeWidth={2} 
                        dot={false} 
                        activeDot={{ r: 6 }}
                        isAnimationActive={false}
                      />
                      <ReferenceLine y={12} stroke="#ef4444" strokeDasharray="3 3" label={{ value: 'Risk Threshold', fill: '#ef4444', fontSize: 10 }} />
                    </LineChart>
                  </ResponsiveContainer>
                ) : (
                   <div className="h-full flex items-center justify-center text-slate-400 bg-slate-50 rounded-lg">
                    Waiting for forecast data...
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default HealthDashboard;