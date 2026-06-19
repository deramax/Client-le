// Toast notifications — context provider + hook. Mirrors legacy `toast(msg)`.
import { createContext, useCallback, useContext, useRef, useState } from 'react';
import { IconCheck } from './Icons.jsx';

const ToastCtx = createContext(() => {});

export function ToastProvider({ children }) {
  const [msg, setMsg] = useState('');
  const [show, setShow] = useState(false);
  const timer = useRef(null);

  const toast = useCallback((text) => {
    setMsg(String(text || ''));
    setShow(true);
    clearTimeout(timer.current);
    timer.current = setTimeout(() => setShow(false), 2600);
  }, []);

  return (
    <ToastCtx.Provider value={toast}>
      {children}
      <div className={`toast${show ? ' show' : ''}`} role="status" aria-live="polite">
        <IconCheck size={17} />
        {msg}
      </div>
    </ToastCtx.Provider>
  );
}

export function useToast() {
  return useContext(ToastCtx);
}
