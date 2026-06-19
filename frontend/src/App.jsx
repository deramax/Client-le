// Routing shell: auth gate + permission-guarded module routes.
import { Navigate, Route, Routes } from 'react-router-dom';
import { useAuth } from './auth/AuthContext.jsx';
import Layout from './components/layout/Layout.jsx';
import AuthScreen from './views/auth/AuthScreen.jsx';
import Dashboard from './views/Dashboard.jsx';
import Demandes from './views/Demandes.jsx';
import Clients from './views/Clients.jsx';
import Rapports from './views/Rapports.jsx';
import Notifications from './views/Notifications.jsx';
import Audit from './views/Audit.jsx';
import Parametres from './views/Parametres.jsx';

function Splash() {
  return (
    <div
      style={{
        position: 'fixed',
        inset: 0,
        display: 'grid',
        placeItems: 'center',
        background: 'var(--bg)',
        backgroundImage: 'var(--bg-grad)',
        color: 'var(--text-3)',
      }}
    >
      Chargement…
    </div>
  );
}

// Renders children only if the user may view the module, else an access notice.
function Guard({ mod, children }) {
  const { can } = useAuth();
  if (!can(mod, 'view')) {
    return (
      <div className="card card-pad" style={{ maxWidth: 520, margin: '40px auto', textAlign: 'center' }}>
        <h3 style={{ marginTop: 0 }}>Accès refusé</h3>
        <p className="cell-sub">Vos droits ne permettent pas d'accéder à ce module.</p>
      </div>
    );
  }
  return children;
}

export default function App() {
  const { isAuthenticated, loading } = useAuth();

  if (loading) return <Splash />;
  if (!isAuthenticated) {
    return (
      <Routes>
        <Route path="*" element={<AuthScreen />} />
      </Routes>
    );
  }

  return (
    <Routes>
      <Route element={<Layout />}>
        <Route index element={<Guard mod="dashboard"><Dashboard /></Guard>} />
        <Route path="demandes" element={<Guard mod="visualisation"><Demandes /></Guard>} />
        <Route path="clients" element={<Guard mod="clients"><Clients /></Guard>} />
        <Route path="clients/:refnum" element={<Guard mod="clients"><Clients /></Guard>} />
        <Route path="rapports" element={<Guard mod="rapports"><Rapports /></Guard>} />
        <Route path="notifications" element={<Guard mod="notifications"><Notifications /></Guard>} />
        <Route path="audit" element={<Guard mod="audit"><Audit /></Guard>} />
        <Route path="parametres" element={<Guard mod="parametres"><Parametres /></Guard>} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Route>
    </Routes>
  );
}
