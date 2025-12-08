import path from 'path';
import { defineConfig, loadEnv } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, '.', '');
  return {
    server: {
      port: 3000,
      host: '0.0.0.0',
    },
    plugins: [react()],

    // Allow Vite to treat .onnx as a static asset
    assetsInclude: ['**/*.onnx'],

    // ✅ Prevent Vite from optimizing or bundling ONNX Runtime Web
    optimizeDeps: {
      exclude: ['onnxruntime-web'],
    },
    build: {
      rollupOptions: {
        external: ['onnxruntime-web'],
      },
    },

    define: {
      'process.env.API_KEY': JSON.stringify(env.GEMINI_API_KEY),
      'process.env.GEMINI_API_KEY': JSON.stringify(env.GEMINI_API_KEY),
    },
    resolve: {
      alias: {
        '@': path.resolve(__dirname, '.'),
      },
    },
  };
});
