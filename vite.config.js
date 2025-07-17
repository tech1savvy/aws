import { defineConfig } from 'vite';

export default defineConfig({
  root: './',
  publicDir: 'public',
  build: {
    outDir: 'dist',
    rollupOptions: {
        input: '/index.html'
    }
  },
  server: {
    host: true,
    port: 5173,
  },
});