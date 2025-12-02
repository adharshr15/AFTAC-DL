import React, { useState } from 'react';
import { Camera, Clock, Tag, AlertCircle } from 'lucide-react';
import { DETECTION_LOGS } from '../constants';

const ObjectDetection: React.FC = () => {
  // Hardcoded path to the assets directory
  const VIDEO_PATH = './assets/video.mp4';
  const [videoError, setVideoError] = useState(false);

  return (
    <div className="space-y-6 animate-fade-in">
       <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
          <div>
            <h2 className="text-2xl font-bold text-slate-800">Object Detection</h2>
            <p className="text-slate-500 text-sm">Real-time vision inference on edge hardware</p>
          </div>
        </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Video Feed Section */}
        <div className="lg:col-span-2 space-y-4">
          <div className="bg-black rounded-xl overflow-hidden shadow-lg aspect-video relative group border-2 border-slate-900">
            {!videoError ? (
               <video 
                 src={VIDEO_PATH} 
                 controls 
                 autoPlay 
                 loop 
                 muted
                 playsInline
                 onError={() => setVideoError(true)}
                 className="w-full h-full object-contain bg-black"
               />
            ) : (
               <div className="absolute inset-0 flex flex-col items-center justify-center text-slate-400 bg-slate-900 p-8 text-center">
                  <AlertCircle className="w-16 h-16 mb-4 text-slate-600" />
                  <p className="text-white font-semibold text-lg">Video Asset Not Found</p>
                  <p className="text-sm text-slate-500 mt-2">
                    Could not load video from <code className="bg-slate-800 px-2 py-1 rounded text-amber-500 font-mono">{VIDEO_PATH}</code>
                  </p>
                  <p className="text-xs text-slate-600 mt-4 max-w-md leading-relaxed">
                    To enable this feature, create an folder named <strong>assets</strong> in your project root and place your video file named <strong>video.mp4</strong> inside it.
                  </p>
               </div>
            )}
            
            {!videoError && (
              <>
                 <div className="absolute top-4 right-4 flex items-center gap-2 bg-red-500/90 text-white text-xs px-2 py-1 rounded-md animate-pulse z-20">
                   <div className="w-2 h-2 bg-white rounded-full"></div>
                   LIVE INFERENCE
                 </div>
                 
                 {/* Simulated Detection Box Overlay */}
                 <div className="absolute top-1/4 left-1/4 w-32 h-32 border-2 border-green-500 rounded-lg z-10 flex flex-col items-start opacity-80 pointer-events-none">
                    <span className="bg-green-500 text-white text-[10px] px-1 font-bold">Person 98%</span>
                 </div>
              </>
            )}
          </div>
          
          <div className="bg-white p-4 rounded-xl border border-slate-200 shadow-sm flex flex-wrap items-center justify-between gap-4">
             <div className="flex items-center gap-2">
                <Camera className="w-4 h-4 text-slate-500" />
                <span className="text-sm font-medium text-slate-600">Source: <span className="text-slate-900 font-mono text-xs">{VIDEO_PATH}</span></span>
             </div>
             <div className="flex items-center gap-2">
                <span className="text-sm font-medium text-slate-600">Model: <span className="text-slate-900">MobileNetV2-Pruned</span></span>
             </div>
             <div className="flex items-center gap-2">
                <span className="text-sm font-medium text-slate-600">FPS: <span className="text-green-600">24.5</span></span>
             </div>
          </div>
        </div>

        {/* Detection Log Section */}
        <div className="lg:col-span-1">
          <div className="bg-white rounded-xl border border-slate-200 shadow-sm h-full flex flex-col">
            <div className="p-4 border-b border-slate-100 bg-slate-50/50 rounded-t-xl">
              <h3 className="font-semibold text-slate-800 flex items-center gap-2">
                <Tag className="w-4 h-4 text-slate-500" />
                Recent Detections
              </h3>
            </div>
            <div className="p-2 overflow-y-auto max-h-[500px] flex-1">
              <div className="space-y-2">
                {DETECTION_LOGS.map((log) => (
                  <div key={log.id} className="flex items-center gap-3 p-3 hover:bg-slate-50 rounded-lg transition-colors border border-transparent hover:border-slate-100 group">
                    <div className="w-10 h-10 bg-blue-50 rounded-lg flex items-center justify-center flex-shrink-0 group-hover:bg-blue-100 transition-colors">
                      <Camera className="w-5 h-5 text-blue-600" />
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-medium text-slate-900">{log.object}</p>
                      <div className="flex items-center gap-2 text-xs text-slate-500">
                         <Clock className="w-3 h-3" />
                         {log.time}
                      </div>
                    </div>
                    <div className="text-right">
                       <span className="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-green-100 text-green-800">
                         {log.confidence}
                       </span>
                    </div>
                  </div>
                ))}
              </div>
            </div>
             <div className="p-3 bg-slate-50 border-t border-slate-100 text-center rounded-b-xl">
                <button className="text-xs text-blue-600 hover:text-blue-800 font-medium hover:underline">View Full Log History</button>
             </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ObjectDetection;