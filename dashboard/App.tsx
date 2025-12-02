import React, { useState } from 'react';
import { 
  Activity, 
  Eye, 
  BarChart2, 
  LayoutDashboard, 
  Settings, 
  Menu,
  X,
  Server
} from 'lucide-react';
import HealthDashboard from './src/HealthDashboard';
import ObjectDetection from './src/ObjectDetection';
import ModelMetrics from './src/ModelMetrics';
import { Tab } from './types';

const App: React.FC = () => {
  const [activeTab, setActiveTab] = useState<Tab>(Tab.HEALTH_MONITOR);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  const renderContent = () => {
    switch (activeTab) {
      case Tab.HEALTH_MONITOR:
        return <HealthDashboard />;
      case Tab.OBJECT_DETECTION:
        return <ObjectDetection />;
      case Tab.MODEL_METRICS:
        return <ModelMetrics />;
      default:
        return <HealthDashboard />;
    }
  };

  const NavItem = ({ tab, icon: Icon, label }: { tab: Tab; icon: React.ElementType; label: string }) => (
    <button
      onClick={() => {
        setActiveTab(tab);
        setIsMobileMenuOpen(false);
      }}
      className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200 ${
        activeTab === tab 
          ? 'bg-blue-600 text-white shadow-md' 
          : 'text-slate-400 hover:bg-slate-800 hover:text-white'
      }`}
    >
      <Icon className="w-5 h-5" />
      <span className="font-medium">{label}</span>
    </button>
  );

  return (
    <div className="min-h-screen bg-slate-50 flex font-sans text-slate-900">
      {/* Sidebar Navigation (Desktop) */}
      <aside className="hidden md:flex flex-col w-64 bg-slate-900 text-white min-h-screen fixed left-0 top-0 z-30">
        <div className="p-6 border-b border-slate-800 flex items-center gap-2">
          <div className="bg-blue-600 p-2 rounded-lg">
            <Server className="w-6 h-6 text-white" />
          </div>
          <div>
            <h1 className="text-xl font-bold tracking-tight">AFTAC DL</h1>
          </div>
        </div>

        <nav className="flex-1 p-4 space-y-2 mt-4">
          <NavItem tab={Tab.HEALTH_MONITOR} icon={Activity} label="Health Monitor" />
          <NavItem tab={Tab.OBJECT_DETECTION} icon={Eye} label="Object Detection" />
          <NavItem tab={Tab.MODEL_METRICS} icon={BarChart2} label="Model Metrics" />
        </nav>

        {/* <div className="p-4 border-t border-slate-800">
          <button className="w-full flex items-center gap-3 px-4 py-3 text-slate-400 hover:text-white hover:bg-slate-800 rounded-lg transition-colors">
            <Settings className="w-5 h-5" />
            <span className="font-medium">Settings</span>
          </button>
        </div> */}
      </aside>

      {/* Mobile Header */}
      <div className="md:hidden fixed top-0 left-0 right-0 bg-slate-900 text-white z-40 px-4 py-3 flex items-center justify-between shadow-md">
         <div className="flex items-center gap-2">
            <Server className="w-6 h-6 text-blue-500" />
            <span className="font-bold text-lg">AFTAC DL</span>
         </div>
         <button onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}>
           {isMobileMenuOpen ? <X /> : <Menu />}
         </button>
      </div>

      {/* Mobile Menu Dropdown */}
      {isMobileMenuOpen && (
        <div className="md:hidden fixed top-14 left-0 right-0 bg-slate-900 z-30 p-4 shadow-xl border-t border-slate-800 animate-slide-in-top">
          <nav className="space-y-2">
            <NavItem tab={Tab.HEALTH_MONITOR} icon={Activity} label="Health Monitor" />
            <NavItem tab={Tab.OBJECT_DETECTION} icon={Eye} label="Object Detection" />
            <NavItem tab={Tab.MODEL_METRICS} icon={BarChart2} label="Model Metrics" />
          </nav>
        </div>
      )}

      {/* Main Content Area */}
      <main className="flex-1 md:ml-64 p-4 md:p-8 pt-20 md:pt-8 min-h-screen transition-all">
        <div className="max-w-7xl mx-auto">
          {renderContent()}
        </div>
      </main>
    </div>
  );
};

export default App;