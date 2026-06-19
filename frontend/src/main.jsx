import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import './styles/legacy.css';

import { ThemeProvider } from './theme/ThemeContext.jsx';
import { ToastProvider, useToast } from './components/Toast.jsx';
import { AuthProvider } from './auth/AuthContext.jsx';
import { DataProvider } from './data/DataContext.jsx';
import App from './App.jsx';

// Bridge the toast hook into AuthProvider (idle-logout notices).
function AuthBridge({ children }) {
  const toast = useToast();
  return (
    <AuthProvider onToast={toast}>
      <DataProvider>{children}</DataProvider>
    </AuthProvider>
  );
}

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <ThemeProvider>
      <ToastProvider>
        <BrowserRouter>
          <AuthBridge>
            <App />
          </AuthBridge>
        </BrowserRouter>
      </ToastProvider>
    </ThemeProvider>
  </StrictMode>
);
