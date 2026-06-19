import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// During local dev, proxy /api to the Django backend so VITE_API_URL can stay '/api'.
export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    proxy: {
      '/api': {
        target: process.env.VITE_DEV_PROXY || 'http://localhost:8000',
        changeOrigin: true,
      },
    },
  },
  build: {
    outDir: 'dist',
    sourcemap: false,
  },
});
