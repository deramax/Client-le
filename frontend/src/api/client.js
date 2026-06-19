// ClienTara API client — fetch wrapper with JWT + refresh-on-401.
// Token storage keys (per spec):
//   cta_access  — short-lived access token
//   cta_refresh — refresh token

const API_BASE = import.meta.env.VITE_API_URL || '/api';

export const tokens = {
  get access() {
    return localStorage.getItem('cta_access') || '';
  },
  get refresh() {
    return localStorage.getItem('cta_refresh') || '';
  },
  set({ access, refresh }) {
    if (access !== undefined) localStorage.setItem('cta_access', access || '');
    if (refresh !== undefined) localStorage.setItem('cta_refresh', refresh || '');
  },
  clear() {
    localStorage.removeItem('cta_access');
    localStorage.removeItem('cta_refresh');
  },
};

// Listeners notified when the session is forcibly cleared (e.g. refresh failed).
const logoutListeners = new Set();
export function onForcedLogout(fn) {
  logoutListeners.add(fn);
  return () => logoutListeners.delete(fn);
}
function fireForcedLogout() {
  tokens.clear();
  logoutListeners.forEach((fn) => {
    try {
      fn();
    } catch (e) {
      /* noop */
    }
  });
}

export class ApiError extends Error {
  constructor(message, status, data) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
    this.data = data;
  }
}

function buildUrl(path) {
  if (/^https?:\/\//i.test(path)) return path;
  const base = API_BASE.replace(/\/$/, '');
  const p = path.startsWith('/') ? path : `/${path}`;
  return `${base}${p}`;
}

async function parseBody(res) {
  const ct = res.headers.get('content-type') || '';
  if (ct.includes('application/json')) {
    try {
      return await res.json();
    } catch (e) {
      return null;
    }
  }
  const text = await res.text();
  return text || null;
}

// Single-flight refresh so concurrent 401s don't trigger multiple refreshes.
let refreshPromise = null;
async function refreshAccess() {
  if (refreshPromise) return refreshPromise;
  const refresh = tokens.refresh;
  if (!refresh) return Promise.resolve(null);

  refreshPromise = (async () => {
    try {
      const res = await fetch(buildUrl('/auth/refresh'), {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ refresh }),
      });
      if (!res.ok) return null;
      const data = await parseBody(res);
      if (data && data.access) {
        tokens.set({ access: data.access });
        return data.access;
      }
      return null;
    } catch (e) {
      return null;
    } finally {
      refreshPromise = null;
    }
  })();

  return refreshPromise;
}

async function request(method, path, body, opts = {}) {
  const { auth = true, isRetry = false, signal } = opts;

  const headers = { ...(opts.headers || {}) };
  let payload = body;
  const isForm = typeof FormData !== 'undefined' && body instanceof FormData;
  if (body !== undefined && body !== null && !isForm) {
    headers['Content-Type'] = headers['Content-Type'] || 'application/json';
    payload = JSON.stringify(body);
  }
  if (auth && tokens.access) {
    headers.Authorization = `Bearer ${tokens.access}`;
  }

  let res;
  try {
    res = await fetch(buildUrl(path), { method, headers, body: payload, signal });
  } catch (e) {
    throw new ApiError('Réseau indisponible', 0, null);
  }

  if (res.status === 401 && auth && !isRetry && tokens.refresh) {
    const newAccess = await refreshAccess();
    if (newAccess) {
      return request(method, path, body, { ...opts, isRetry: true });
    }
    fireForcedLogout();
  }

  if (res.status === 204) return null;

  const data = await parseBody(res);
  if (!res.ok) {
    const msg =
      (data && (data.detail || data.message || data.error)) ||
      `Erreur ${res.status}`;
    throw new ApiError(msg, res.status, data);
  }
  return data;
}

export const api = {
  get: (path, opts) => request('GET', path, undefined, opts),
  post: (path, body, opts) => request('POST', path, body, opts),
  patch: (path, body, opts) => request('PATCH', path, body, opts),
  put: (path, body, opts) => request('PUT', path, body, opts),
  del: (path, opts) => request('DELETE', path, undefined, opts),
  base: API_BASE,
};

export default api;
