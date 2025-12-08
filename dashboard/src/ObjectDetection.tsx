import React, { useState } from 'react';
import { Camera, Clock, Tag, AlertCircle } from 'lucide-react';
import { DETECTION_LOGS } from '../constants';

const ObjectDetection: React.FC = () => {
  // Hardcoded path to the assets directory
  const VIDEO_PATH = '/assets/video.mp4';
  const [videoError, setVideoError] = useState(false);

  return (
    <div className="space-y-6 animate-fade-in">
      <div>
       <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
          <div>
            <h2 className="text-2xl font-bold text-slate-800">Object Detection</h2>
            <p className="text-slate-500 text-sm">Real-time vision inference on edge hardware</p>
          </div>
        </div>

        <div className="lg:col-span-2 space-y-4">
          <div className="bg-black rounded-xl overflow-hidden shadow-lg aspect-video relative group border-2 border-slate-900">
              {videoError ? (
                  <div className="flex items-center justify-center w-full h-full bg-red-100/20">
                      <p className="text-white flex flex-col items-center gap-2">
                          <AlertCircle className="w-6 h-6 text-red-400" />
                          <span className="font-semibold">Error Loading Video</span>
                          <span className="text-sm text-red-300">Check the path and video format.</span>
                      </p>
                  </div>
              ) : (
                  <video 
                      src={VIDEO_PATH} 
                      controls 
                      autoPlay 
                      loop 
                      muted
                      playsInline
                      onError={() => setVideoError(true)} // This line correctly sets the error state
                      className="w-full h-full object-contain bg-black"
                  />
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
             {/* <div className="flex items-center gap-2">
                <span className="text-sm font-medium text-slate-600">FPS: <span className="text-green-600">24.5</span></span>
             </div> */}
          </div>
        </div>

        {/* Detection Log Section */}
        {/* <div className="lg:col-span-1">
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
        </div> */}
      </div>
    </div>
  );
};

export default ObjectDetection;