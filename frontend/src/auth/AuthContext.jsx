// Auth context: session user, login/logout, permission helper, idle auto-logout.
import { createContext, useCallback, useContext, useEffect, useRef, useState } from 'react';
import api, { tokens, onForcedLogout } from '../api/client.js';

const AuthCtx = createContext(null);

const IDLE_MS = 120 * 60 * 1000; // 120 minutes
const WARN_MS = 118 * 60 * 1000;

export function AuthProvider({ children, onToast }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const idleTimer = useRef(null);
  const warnTimer = useRef(null);
  const toastRef = useRef(onToast);
  toastRef.current = onToast;

  const logout = useCallback(
    (reason) => {
      tokens.clear();
      setUser(null);
      clearTimeout(idleTimer.current);
      clearTimeout(warnTimer.current);
      if (reason === 'inactivité' && toastRef.current) {
        toastRef.current('Déconnexion automatique (inactivité)');
      }
    },
    []
  );

  // Idle auto-logout (only while authenticated).
  const resetIdle = useCallback(() => {
    clearTimeout(idleTimer.current);
    clearTimeout(warnTimer.current);
    if (!tokens.access) return;
    warnTimer.current = setTimeout(() => {
      if (toastRef.current) toastRef.current('Déconnexion automatique dans 2 minutes (inactivité)');
    }, WARN_MS);
    idleTimer.current = setTimeout(() => logout('inactivité'), IDLE_MS);
  }, [logout]);

  // Bootstrap: if we have a token, fetch /auth/me.
  useEffect(() => {
    let alive = true;
    (async () => {
      if (tokens.access) {
        try {
          const me = await api.get('/auth/me');
          if (alive) {
            setUser(me);
            resetIdle();
          }
        } catch (e) {
          tokens.clear();
        }
      }
      if (alive) setLoading(false);
    })();
    return () => {
      alive = false;
    };
  }, [resetIdle]);

  // React to forced logouts triggered by the API client (refresh failed).
  useEffect(() => {
    return onForcedLogout(() => {
      setUser(null);
      clearTimeout(idleTimer.current);
      clearTimeout(warnTimer.current);
    });
  }, []);

  // Bind activity listeners while logged in.
  useEffect(() => {
    if (!user) return undefined;
    const events = ['mousemove', 'keydown', 'click', 'touchstart', 'scroll'];
    const handler = () => resetIdle();
    events.forEach((ev) => document.addEventListener(ev, handler, { passive: true }));
    resetIdle();
    return () => {
      events.forEach((ev) => document.removeEventListener(ev, handler));
      clearTimeout(idleTimer.current);
      clearTimeout(warnTimer.current);
    };
  }, [user, resetIdle]);

  // Accepts the {access, refresh, user} payload and establishes the session.
  const completeLogin = useCallback(
    ({ access, refresh, user: u }) => {
      tokens.set({ access, refresh });
      setUser(u);
      resetIdle();
      return u;
    },
    [resetIdle]
  );

  const refreshMe = useCallback(async () => {
    const me = await api.get('/auth/me');
    setUser(me);
    return me;
  }, []);

  // Permission helper: admin always true; otherwise check the permissions matrix.
  const can = useCallback(
    (mod, cap = 'view') => {
      if (!user) return false;
      if (user.role === 'administrateur') return true;
      const p = user.permissions && user.permissions[mod];
      return !!(p && p[cap]);
    },
    [user]
  );

  const value = {
    user,
    loading,
    isAuthenticated: !!user,
    isAdmin: !!(user && user.role === 'administrateur'),
    completeLogin,
    logout,
    can,
    refreshMe,
    setUser,
  };

  return <AuthCtx.Provider value={value}>{children}</AuthCtx.Provider>;
}

export function useAuth() {
  const ctx = useContext(AuthCtx);
  if (!ctx) throw new Error('useAuth must be used within AuthProvider');
  return ctx;
}
