// Full-screen auth layer: setup (first user), login, register, MFA, and
// forced password change. Mirrors the legacy auth flow against the JWT API.
import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import api, { ApiError, tokens } from '../../api/client.js';
import { useAuth } from '../../auth/AuthContext.jsx';
import { useToast } from '../../components/Toast.jsx';
import { ROLES } from '../../lib/constants.js';
import logo from '../../assets/clientara-logo.png';
import mark from '../../assets/clientara-mark.png';

const inputStyle = {
  width: '100%',
  padding: '11px 13px',
  border: '1px solid var(--border)',
  borderRadius: 10,
  background: 'var(--surface-2)',
  color: 'var(--text)',
  font: 'inherit',
  fontSize: 14,
  marginBottom: 11,
  boxSizing: 'border-box',
};
const labelStyle = { fontSize: 12, fontWeight: 600, color: 'var(--text-2)', margin: '2px 0 5px' };

function Field({ label, ...rest }) {
  return (
    <>
      <div style={labelStyle}>{label}</div>
      <input style={inputStyle} autoComplete="off" {...rest} />
    </>
  );
}

function ErrLine({ msg }) {
  if (!msg) return null;
  return <div style={{ color: '#dc2626', fontSize: 12.5, margin: '-4px 0 10px' }}>{msg}</div>;
}

function CardShell({ title, sub, children }) {
  return (
    <div
      style={{
        width: '100%',
        maxWidth: 420,
        background: 'var(--surface)',
        border: '1px solid var(--border)',
        borderRadius: 18,
        boxShadow: '0 24px 60px rgba(0,0,0,.28)',
        overflow: 'hidden',
      }}
    >
      <div
        style={{
          padding: '22px 24px',
          borderBottom: '1px solid var(--border)',
          display: 'flex',
          alignItems: 'center',
          gap: 13,
        }}
      >
        <img src={mark} width={40} height={40} alt="ClienTara" style={{ borderRadius: 9, objectFit: 'contain' }} />
        <div>
          <div style={{ fontFamily: 'var(--font-display)', fontWeight: 700, fontSize: 18, color: 'var(--text)' }}>
            {title}
          </div>
          <div style={{ fontSize: 12.5, color: 'var(--text-3)' }}>{sub}</div>
        </div>
      </div>
      <div style={{ padding: '22px 24px' }}>{children}</div>
    </div>
  );
}

const note = (
  <p style={{ fontSize: 11.5, color: 'var(--text-3)', margin: '14px 0 0', textAlign: 'center' }}>
    Accès sécurisé à votre espace de fidélisation ClienTara.
  </p>
);

export default function AuthScreen() {
  const { completeLogin } = useAuth();
  const toast = useToast();
  const navigate = useNavigate();

  const [mode, setMode] = useState('login'); // login | setup | register | mfa | force
  const [needsSetupChecked, setNeedsSetupChecked] = useState(false);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState('');

  // form state
  const [f, setF] = useState({});
  const upd = (k) => (e) => setF((s) => ({ ...s, [k]: e.target.value }));

  // MFA / force-change carry state
  const [mfaToken, setMfaToken] = useState('');
  const [pendingTokens, setPendingTokens] = useState(null); // {access, refresh, user}

  useEffect(() => {
    let alive = true;
    (async () => {
      try {
        const r = await api.get('/auth/needs_setup', { auth: false });
        if (alive && r && r.needs_setup) setMode('setup');
      } catch (e) {
        /* assume setup not needed */
      } finally {
        if (alive) setNeedsSetupChecked(true);
      }
    })();
    return () => {
      alive = false;
    };
  }, []);

  const fail = (m) => {
    setErr(m);
    setBusy(false);
  };

  const finish = (data) => {
    completeLogin(data);
    navigate('/', { replace: true });
  };

  const doLogin = async () => {
    setErr('');
    setBusy(true);
    try {
      const data = await api.post('/auth/login', { login: f.login || '', password: f.password || '' }, { auth: false });
      if (data.mfa_required) {
        setMfaToken(data.mfa_token);
        setMode('mfa');
        setBusy(false);
        return;
      }
      if (data.must_change_password) {
        // Establish session temporarily so change_password is authorized.
        tokens.set({ access: data.access, refresh: data.refresh });
        setPendingTokens(data);
        setMode('force');
        setBusy(false);
        return;
      }
      finish(data);
    } catch (e) {
      fail(e instanceof ApiError && e.status === 401 ? 'Identifiant ou mot de passe incorrect.' : e.message);
    }
  };

  const doSetup = async () => {
    setErr('');
    if (!(f.name || '').trim()) return fail('Le nom complet est obligatoire.');
    if ((f.login || '').length < 3) return fail("L'identifiant doit comporter au moins 3 caractères.");
    if ((f.password || '').length < 8) return fail('Le mot de passe doit comporter au moins 8 caractères.');
    if (f.password !== f.password2) return fail('Les deux mots de passe ne correspondent pas.');
    setBusy(true);
    try {
      await api.post('/auth/setup', { fullName: f.name.trim(), login: f.login.trim(), password: f.password }, { auth: false });
      toast('Compte administrateur créé');
      setF({});
      setMode('login');
      setBusy(false);
    } catch (e) {
      fail(e.message);
    }
  };

  const doRegister = async () => {
    setErr('');
    if (!(f.name || '').trim()) return fail('Le nom complet est obligatoire.');
    if ((f.login || '').length < 3) return fail("L'identifiant doit comporter au moins 3 caractères.");
    if ((f.password || '').length < 8) return fail('Le mot de passe doit comporter au moins 8 caractères.');
    if (f.password !== f.password2) return fail('Les deux mots de passe ne correspondent pas.');
    setBusy(true);
    try {
      const data = await api.post(
        '/auth/register',
        {
          fullName: f.name.trim(),
          login: f.login.trim(),
          email: (f.email || '').trim(),
          phone: (f.phone || '').trim(),
          role: f.role || 'agent',
          password: f.password,
        },
        { auth: false }
      );
      toast('Compte créé — bienvenue ' + f.name.trim());
      finish(data);
    } catch (e) {
      fail(e.message);
    }
  };

  const doMfa = async () => {
    setErr('');
    setBusy(true);
    try {
      const data = await api.post('/auth/mfa/verify', { mfa_token: mfaToken, code: (f.code || '').trim() }, { auth: false });
      finish(data);
    } catch (e) {
      fail('Code invalide. Réessayez.');
    }
  };

  const doForce = async () => {
    setErr('');
    if ((f.password || '').length < 8) return fail('Le mot de passe doit comporter au moins 8 caractères.');
    if (f.password !== f.password2) return fail('Les deux mots de passe ne correspondent pas.');
    setBusy(true);
    try {
      await api.post('/auth/change_password', { password: f.password });
      toast('Mot de passe mis à jour');
      finish(pendingTokens);
    } catch (e) {
      fail(e.message);
    }
  };

  const wrapStyle = {
    position: 'fixed',
    inset: 0,
    zIndex: 4000,
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
    background: 'var(--bg)',
    backgroundImage: 'var(--bg-grad)',
    overflow: 'auto',
  };

  if (!needsSetupChecked) {
    return <div style={wrapStyle} />;
  }

  return (
    <div style={wrapStyle}>
      {mode === 'login' && (
        <div className="login-wrap">
          <div className="login-card">
            <img className="login-logo" src={logo} alt="ClienTara" />
            <h1 className="login-welcome">Bienvenue sur Clientara</h1>
            <p className="login-sub">Connectez-vous à votre espace de fidélisation</p>
            <div className="login-form">
              <Field
                label="Identifiant"
                type="text"
                placeholder="Votre identifiant"
                value={f.login || ''}
                onChange={upd('login')}
              />
              <Field
                label="Mot de passe"
                type="password"
                placeholder="Votre mot de passe"
                value={f.password || ''}
                onChange={upd('password')}
                onKeyDown={(e) => e.key === 'Enter' && doLogin()}
              />
              <ErrLine msg={err} />
              <button
                className="btn btn-primary"
                style={{ width: '100%', justifyContent: 'center', marginTop: 4 }}
                onClick={doLogin}
                disabled={busy}
              >
                Se connecter
              </button>
              <div style={{ marginTop: 16, paddingTop: 16, borderTop: '1px solid var(--border)', textAlign: 'center' }}>
                <span style={{ fontSize: 12.5, color: 'var(--text-3)' }}>Pas encore de compte&nbsp;?</span>
                <br />
                <button
                  className="btn btn-ghost btn-sm"
                  style={{ marginTop: 6 }}
                  onClick={() => {
                    setErr('');
                    setMode('register');
                  }}
                >
                  Créer mon compte
                </button>
              </div>
              {note}
            </div>
          </div>
        </div>
      )}

      {mode === 'setup' && (
        <CardShell title="Bienvenue sur ClienTara" sub="Créez le premier compte administrateur">
          <Field label="Nom complet" placeholder="Nom et prénom" value={f.name || ''} onChange={upd('name')} />
          <Field label="Identifiant" placeholder="3 caractères minimum" value={f.login || ''} onChange={upd('login')} />
          <Field label="Mot de passe" type="password" placeholder="8 caractères minimum" value={f.password || ''} onChange={upd('password')} />
          <Field
            label="Confirmer le mot de passe"
            type="password"
            placeholder="Répétez le mot de passe"
            value={f.password2 || ''}
            onChange={upd('password2')}
          />
          <ErrLine msg={err} />
          <button
            className="btn btn-primary"
            style={{ width: '100%', justifyContent: 'center', marginTop: 4 }}
            onClick={doSetup}
            disabled={busy}
          >
            Créer le compte administrateur
          </button>
          {note}
        </CardShell>
      )}

      {mode === 'register' && (
        <CardShell title="Créer mon compte" sub="Renseignez vos informations pour accéder à ClienTara">
          <Field label="Nom complet" placeholder="Nom et prénom" value={f.name || ''} onChange={upd('name')} />
          <Field label="Identifiant" placeholder="3 caractères minimum" value={f.login || ''} onChange={upd('login')} />
          <Field label="Email (facultatif)" type="email" placeholder="vous@exemple.mg" value={f.email || ''} onChange={upd('email')} />
          <Field label="Téléphone (facultatif)" placeholder="Numéro de téléphone" value={f.phone || ''} onChange={upd('phone')} />
          <div style={labelStyle}>Rôle</div>
          <select style={inputStyle} value={f.role || 'agent'} onChange={upd('role')}>
            {ROLES.filter((r) => r.key !== 'administrateur').map((r) => (
              <option key={r.key} value={r.key}>
                {r.name}
              </option>
            ))}
          </select>
          <Field label="Mot de passe" type="password" placeholder="8 caractères minimum" value={f.password || ''} onChange={upd('password')} />
          <Field
            label="Confirmer le mot de passe"
            type="password"
            placeholder="Répétez le mot de passe"
            value={f.password2 || ''}
            onChange={upd('password2')}
          />
          <ErrLine msg={err} />
          <button
            className="btn btn-primary"
            style={{ width: '100%', justifyContent: 'center', marginTop: 4 }}
            onClick={doRegister}
            disabled={busy}
          >
            Créer mon compte
          </button>
          <button
            className="btn btn-ghost btn-sm"
            style={{ width: '100%', justifyContent: 'center', marginTop: 10 }}
            onClick={() => {
              setErr('');
              setMode('login');
            }}
          >
            ← Retour à la connexion
          </button>
          <p style={{ fontSize: 11, color: 'var(--text-3)', margin: '12px 0 0', textAlign: 'center' }}>
            Le rôle « Administrateur » n'est attribuable que par un administrateur existant.
          </p>
        </CardShell>
      )}

      {mode === 'mfa' && (
        <CardShell title="Vérification en deux étapes" sub="Saisissez le code de votre application d'authentification">
          <Field
            label="Code à 6 chiffres"
            placeholder="000000"
            value={f.code || ''}
            onChange={upd('code')}
            onKeyDown={(e) => e.key === 'Enter' && doMfa()}
            inputMode="numeric"
          />
          <ErrLine msg={err} />
          <button
            className="btn btn-primary"
            style={{ width: '100%', justifyContent: 'center', marginTop: 4 }}
            onClick={doMfa}
            disabled={busy}
          >
            Vérifier
          </button>
          <button
            className="btn btn-ghost btn-sm"
            style={{ width: '100%', justifyContent: 'center', marginTop: 10 }}
            onClick={() => {
              setErr('');
              setMode('login');
            }}
          >
            ← Annuler
          </button>
        </CardShell>
      )}

      {mode === 'force' && (
        <CardShell title="Changement de mot de passe requis" sub="Pour votre première connexion, choisissez un nouveau mot de passe">
          <Field label="Nouveau mot de passe" type="password" placeholder="8 caractères minimum" value={f.password || ''} onChange={upd('password')} />
          <Field
            label="Confirmer le nouveau mot de passe"
            type="password"
            placeholder="Répétez le mot de passe"
            value={f.password2 || ''}
            onChange={upd('password2')}
          />
          <ErrLine msg={err} />
          <button
            className="btn btn-primary"
            style={{ width: '100%', justifyContent: 'center', marginTop: 4 }}
            onClick={doForce}
            disabled={busy}
          >
            Valider et continuer
          </button>
        </CardShell>
      )}
    </div>
  );
}
