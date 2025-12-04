import React from 'react';
import { METRICS_DATA } from '../constants';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell, Legend } from 'recharts';
import { Cpu, HardDrive, Zap, TrendingUp } from 'lucide-react';

const ModelMetrics: React.FC = () => {
  // Data for visual comparison chart
  const comparisonData = [
    { name: 'Accuracy', value: 95, type: 'Baseline' },
    { name: 'Accuracy', value: 94, type: 'Optimized' },
    { name: 'Size (MB)', value: 50, type: 'Baseline' },
    { name: 'Size (MB)', value: 0.25, type: 'Optimized' },
  ];

  const getIcon = (metricName: string) => {
    switch (metricName) {
      case 'Latency': return <Cpu className="w-5 h-5 text-blue-500" />;
      case 'Memory Footprint': return <HardDrive className="w-5 h-5 text-purple-500" />;
      case 'Power Consumption': return <Zap className="w-5 h-5 text-yellow-500" />;
      default: return <TrendingUp className="w-5 h-5 text-green-500" />;
    }
  };

  return (
    <div className="space-y-6 animate-fade-in">
      <div>
        <h2 className="text-2xl font-bold text-slate-800">Model Metrics</h2>
        <p className="text-slate-500 text-sm">Metrics on the two model's accuracies, sizes, etc.</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {METRICS_DATA.map((item, index) => (
          <div key={index} className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm hover:shadow-md transition-shadow">
            <div className="flex items-start justify-between mb-4">
              <div className="flex items-center gap-3">
                <div className="p-2 bg-slate-50 rounded-lg">
                  {getIcon(item.metric)}
                </div>
                <h3 className="font-bold text-slate-800">{item.metric}</h3>
              </div>
              <span className="text-xs font-semibold px-2 py-1 bg-green-100 text-green-800 rounded-full">
                {item.improvement}
              </span>
            </div>
            
            <div className="grid grid-cols-2 gap-4 mb-4">
              <div className="space-y-1">
                <p className="text-xs text-slate-400 uppercase tracking-wider">Pruned + Optimized</p>
                <p className="text-2xl font-mono text-slate-900 font-bold">{item.optimized}</p>
              </div>
            </div>
            
            {/* <p className="text-sm text-slate-500 pt-4 border-t border-slate-100">
              {item.detail}
            </p> */}
          </div>
        ))}
      </div>
    </div>
  );
};

export default ModelMetrics;