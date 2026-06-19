// Shared app data: demandes, clients directory, referentiels, notifications.
// Fetched after authentication; exposes refresh helpers used after mutations.
import { createContext, useCallback, useContext, useEffect, useState } from 'react';
import api from '../api/client.js';
import { useAuth } from '../auth/AuthContext.jsx';

const DataCtx = createContext(null);

const EMPTY_REF = {
  Sites: [],
  Agents: [],
  Technologies: [],
  Produits: [],
  Requetes: [],
  Motifs: [],
  Actions: [],
  Niveaux: ['En Attente', 'Cloturé'],
  Priorites: ['Faible', 'Normale', 'Haute', 'Critique'],
};

export function DataProvider({ children }) {
  const { isAuthenticated } = useAuth();
  const [demandes, setDemandes] = useState([]);
  const [clients, setClients] = useState([]);
  const [ref, setRef] = useState(EMPTY_REF);
  const [notifs, setNotifs] = useState({ items: [], unread: 0 });
  const [loaded, setLoaded] = useState(false);
  const [error, setError] = useState(null);

  const loadDemandes = useCallback(async () => {
    const data = await api.get('/demandes/');
    setDemandes(Array.isArray(data) ? data : data?.results || []);
  }, []);

  const loadClients = useCallback(async () => {
    const data = await api.get('/clients/');
    setClients(Array.isArray(data) ? data : data?.results || []);
  }, []);

  const loadRef = useCallback(async () => {
    const data = await api.get('/referentiels/');
    setRef({ ...EMPTY_REF, ...(data || {}) });
  }, []);

  const loadNotifs = useCallback(async () => {
    try {
      const data = await api.get('/notifications/');
      setNotifs({ items: data?.items || [], unread: data?.unread || 0 });
    } catch (e) {
      /* notifications are non-critical */
    }
  }, []);

  const refreshAll = useCallback(async () => {
    setError(null);
    try {
      await Promise.all([loadDemandes(), loadClients(), loadRef(), loadNotifs()]);
    } catch (e) {
      setError(e);
    } finally {
      setLoaded(true);
    }
  }, [loadDemandes, loadClients, loadRef, loadNotifs]);

  useEffect(() => {
    if (isAuthenticated) {
      setLoaded(false);
      refreshAll();
    } else {
      setDemandes([]);
      setClients([]);
      setRef(EMPTY_REF);
      setNotifs({ items: [], unread: 0 });
      setLoaded(false);
    }
  }, [isAuthenticated, refreshAll]);

  const markAllRead = useCallback(async () => {
    await api.post('/notifications/read_all');
    setNotifs((n) => ({ items: n.items.map((i) => ({ ...i, read: true })), unread: 0 }));
  }, []);

  const value = {
    demandes,
    clients,
    ref,
    notifs,
    loaded,
    error,
    refreshAll,
    loadDemandes,
    loadClients,
    loadRef,
    loadNotifs,
    markAllRead,
    setNotifs,
  };

  return <DataCtx.Provider value={value}>{children}</DataCtx.Provider>;
}

export function useData() {
  const ctx = useContext(DataCtx);
  if (!ctx) throw new Error('useData must be used within DataProvider');
  return ctx;
}
