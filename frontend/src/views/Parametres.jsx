// Settings: appearance/themes, accounts CRUD, referentiels, roles matrix,
// security (password + MFA enrolment), and data export.
import { useEffect, useState } from 'react';
import { useTheme } from '../theme/ThemeContext.jsx';
import { useAuth } from '../auth/AuthContext.jsx';
import { useData } from '../data/DataContext.jsx';
import { useToast } from '../components/Toast.jsx';
import api from '../api/client.js';
import Modal from '../components/Modal.jsx';
import { THEME_META, THEME_SWATCHES, ROLES, CAPS } from '../lib/constants.js';
import { downloadFile } from '../lib/demande.js';
import { IconTheme, IconUser, IconDb, IconShield, IconList } from '../components/Icons.jsx';

const TABS = [
  { key: 'apparence', label: 'Apparence', icon: <IconTheme size={15} /> },
  { key: 'comptes', label: 'Comptes', icon: <IconUser size={15} /> },
  { key: 'ref', label: 'Référentiels', icon: <IconList size={15} /> },
  { key: 'roles', label: 'Rôles', icon: <IconShield size={15} /> },
  { key: 'securite', label: 'Sécurité', icon: <IconShield size={15} /> },
  { key: 'donnees', label: 'Données', icon: <IconDb size={15} /> },
];

export default function Parametres() {
  const [tab, setTab] = useState('apparence');
  return (
    <div>
      <div className="seg" style={{ marginBottom: 16, flexWrap: 'wrap' }}>
        {TABS.map((t) => (
          <button key={t.key} className={tab === t.key ? 'active' : ''} onClick={() => setTab(t.key)}>
            {t.icon} {t.label}
          </button>
        ))}
      </div>
      {tab === 'apparence' && <Apparence />}
      {tab === 'comptes' && <Comptes />}
      {tab === 'ref' && <Referentiels />}
      {tab === 'roles' && <RolesMatrix />}
      {tab === 'securite' && <Securite />}
      {tab === 'donnees' && <Donnees />}
    </div>
  );
}

function Apparence() {
  const { theme, setTheme } = useTheme();
  const toast = useToast();
  return (
    <div className="grid g-2e">
      {Object.keys(THEME_META).map((key) => {
        const sw = THEME_SWATCHES[key] || [];
        return (
          <div
            key={key}
            className={`theme-card${theme === key ? ' active' : ''}`}
            onClick={() => {
              setTheme(key);
              toast('Thème : ' + THEME_META[key].name);
            }}
          >
            <div style={{ display: 'flex', gap: 6, marginBottom: 12 }}>
              {sw.map((c, i) => (
                <span key={i} style={{ width: 26, height: 26, borderRadius: 8, background: c, border: '1px solid rgba(0,0,0,.1)' }} />
              ))}
            </div>
            <div style={{ fontFamily: 'var(--font-display)', fontWeight: 700 }}>{THEME_META[key].name}</div>
            <div className="cell-sub">{THEME_META[key].desc}</div>
          </div>
        );
      })}
    </div>
  );
}

function Referentiels() {
  const { ref } = useData();
  return (
    <div className="grid g-3">
      {Object.entries(ref).map(([cat, vals]) => (
        <div className="card" key={cat}>
          <div className="card-h"><div><h3>{cat}</h3><p>{vals.length} valeur(s)</p></div></div>
          <div className="card-pad" style={{ display: 'flex', flexWrap: 'wrap', gap: 6 }}>
            {vals.map((v) => <span className="badge b-neutral" key={v}>{v}</span>)}
            {!vals.length && <span className="cell-sub">—</span>}
          </div>
        </div>
      ))}
    </div>
  );
}

function RolesMatrix() {
  const [roles, setRoles] = useState(null);
  useEffect(() => {
    api.get('/accounts/roles/').then(setRoles).catch(() => setRoles([]));
  }, []);
  if (!roles) return <div className="card card-pad">Chargement…</div>;
  const modules = roles.length ? Object.keys(roles[0].permissions || {}) : [];
  return (
    <div className="card">
      <div className="card-h"><div><h3>Matrice des rôles</h3><p>Permissions par module (lecture seule)</p></div></div>
      <div className="tbl-wrap">
        <table className="tbl">
          <thead>
            <tr><th>Rôle</th>{modules.map((m) => <th key={m}>{m}</th>)}</tr>
          </thead>
          <tbody>
            {roles.map((r) => (
              <tr className="norow" key={r.key}>
                <td className="cell-strong">{r.name}</td>
                {modules.map((m) => {
                  const p = r.permissions[m] || {};
                  const on = CAPS.filter((c) => p[c]).map((c) => c[0].toUpperCase()).join('');
                  return <td key={m} className="cell-sub">{on || '—'}</td>;
                })}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <div className="card-pad cell-sub">Légende : V (voir) · C (créer) · E (éditer) · D (supprimer)</div>
    </div>
  );
}

function Donnees() {
  const { demandes, clients } = useData();
  const toast = useToast();
  const exportJSON = () => {
    const blob = JSON.stringify({ exportedAt: new Date().toISOString(), demandes, clients }, null, 2);
    downloadFile(blob, 'clientara-export.json', 'application/json');
    toast('Export généré');
  };
  return (
    <div className="card">
      <div className="card-h"><div><h3>Export des données</h3><p>{demandes.length} demandes · {clients.length} clients</p></div></div>
      <div className="card-pad">
        <button className="btn btn-primary" onClick={exportJSON}><IconDb size={16} /> Exporter en JSON</button>
        <p className="cell-sub" style={{ marginTop: 12 }}>
          L'export contient les demandes et le répertoire clients au format JSON.
        </p>
      </div>
    </div>
  );
}

function Securite() {
  const { user, refreshMe } = useAuth();
  const toast = useToast();
  const [pw, setPw] = useState('');
  const [pw2, setPw2] = useState('');
  const [enrol, setEnrol] = useState(null); // {secret, otpauth_url}
  const [code, setCode] = useState('');

  const changePw = async () => {
    if (pw.length < 8) return toast('8 caractères minimum.');
    if (pw !== pw2) return toast('Les mots de passe ne correspondent pas.');
    try {
      await api.post('/auth/change_password', { password: pw });
      setPw('');
      setPw2('');
      toast('Mot de passe mis à jour');
    } catch (e) {
      toast(e.message);
    }
  };

  const startMfa = async () => {
    try {
      setEnrol(await api.post('/auth/mfa/setup'));
    } catch (e) {
      toast(e.message);
    }
  };
  const enableMfa = async () => {
    try {
      await api.post('/auth/mfa/enable', { code: code.trim() });
      setEnrol(null);
      setCode('');
      await refreshMe();
      toast('MFA activé');
    } catch (e) {
      toast(e.message || 'Code invalide');
    }
  };
  const disableMfa = async () => {
    try {
      await api.post('/auth/mfa/disable');
      await refreshMe();
      toast('MFA désactivé');
    } catch (e) {
      toast(e.message);
    }
  };

  const inp = { width: '100%', padding: '10px 12px', border: '1px solid var(--border)', borderRadius: 10, background: 'var(--surface-2)', color: 'var(--text)', font: 'inherit', marginBottom: 10 };

  return (
    <div className="grid g-2e">
      <div className="card">
        <div className="card-h"><div><h3>Mot de passe</h3><p>Modifier votre mot de passe</p></div></div>
        <div className="card-pad">
          <input style={inp} type="password" placeholder="Nouveau mot de passe" value={pw} onChange={(e) => setPw(e.target.value)} />
          <input style={inp} type="password" placeholder="Confirmer" value={pw2} onChange={(e) => setPw2(e.target.value)} />
          <button className="btn btn-primary" onClick={changePw}>Mettre à jour</button>
        </div>
      </div>

      <div className="card">
        <div className="card-h">
          <div><h3>Double authentification (MFA)</h3><p>{user?.mfa_enabled ? 'Activée' : 'Désactivée'}</p></div>
        </div>
        <div className="card-pad">
          {user?.mfa_enabled ? (
            <button className="btn btn-danger" onClick={disableMfa}>Désactiver le MFA</button>
          ) : enrol ? (
            <>
              <p className="cell-sub">Ajoutez ce compte à votre application d'authentification (TOTP) :</p>
              <code style={{ display: 'block', wordBreak: 'break-all', background: 'var(--surface-2)', border: '1px solid var(--border)', borderRadius: 10, padding: 10, marginBottom: 10, fontSize: 12 }}>
                {enrol.otpauth_url}
              </code>
              <p className="cell-sub">Clé secrète : <b>{enrol.secret}</b></p>
              <input style={inp} placeholder="Code à 6 chiffres" inputMode="numeric" value={code} onChange={(e) => setCode(e.target.value)} />
              <button className="btn btn-primary" onClick={enableMfa}>Vérifier et activer</button>
            </>
          ) : (
            <button className="btn btn-primary" onClick={startMfa}><IconShield size={16} /> Activer le MFA</button>
          )}
        </div>
      </div>
    </div>
  );
}

const EMPTY_ACCOUNT = { login: '', fullName: '', email: '', phone: '', role: 'agent', active: true, password: '' };

function Comptes() {
  const { can } = useAuth();
  const toast = useToast();
  const [users, setUsers] = useState(null);
  const [edit, setEdit] = useState(null); // account object | null
  const canEdit = can('parametres', 'edit');

  const load = () => api.get('/accounts/users/').then(setUsers).catch(() => setUsers([]));
  useEffect(() => {
    load();
  }, []);

  const save = async (acc) => {
    try {
      const payload = {
        login: acc.login,
        fullName: acc.fullName,
        email: acc.email,
        phone: acc.phone,
        role: acc.role,
        active: acc.active,
      };
      if (acc.password) payload.password = acc.password;
      if (acc.id) await api.patch(`/accounts/users/${acc.id}/`, payload);
      else await api.post('/accounts/users/', payload);
      toast('Compte enregistré');
      setEdit(null);
      load();
    } catch (e) {
      toast(e.message || 'Enregistrement impossible');
    }
  };

  const toggleActive = async (u) => {
    try {
      await api.patch(`/accounts/users/${u.id}/`, { active: !u.active });
      load();
    } catch (e) {
      toast(e.message);
    }
  };

  if (!users) return <div className="card card-pad">Chargement…</div>;

  return (
    <div className="card">
      <div className="card-h">
        <div><h3>Comptes utilisateurs</h3><p>{users.length} compte(s)</p></div>
        {canEdit && <button className="btn btn-primary btn-sm" onClick={() => setEdit({ ...EMPTY_ACCOUNT })}>+ Nouveau compte</button>}
      </div>
      <div className="tbl-wrap">
        <table className="tbl">
          <thead>
            <tr><th>Nom</th><th>Identifiant</th><th>Rôle</th><th>État</th><th>MFA</th>{canEdit && <th></th>}</tr>
          </thead>
          <tbody>
            {users.map((u) => (
              <tr className="norow" key={u.id}>
                <td className="cell-strong">{u.fullName || '—'}</td>
                <td>{u.login}</td>
                <td>{u.roleName || u.role}</td>
                <td><span className={`badge ${u.active ? 'b-success' : 'b-neutral'}`}>{u.active ? 'Actif' : 'Inactif'}</span></td>
                <td>{u.mfa_enabled ? '✓' : '—'}</td>
                {canEdit && (
                  <td style={{ textAlign: 'right', whiteSpace: 'nowrap' }}>
                    <button className="btn btn-sm btn-ghost" onClick={() => setEdit({ ...u, password: '' })}>Modifier</button>
                    <button className="btn btn-sm btn-ghost" onClick={() => toggleActive(u)}>{u.active ? 'Désactiver' : 'Activer'}</button>
                  </td>
                )}
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {edit && <AccountForm acc={edit} onClose={() => setEdit(null)} onSave={save} />}
    </div>
  );
}

function AccountForm({ acc, onClose, onSave }) {
  const [f, setF] = useState(acc);
  const upd = (k) => (e) => setF((s) => ({ ...s, [k]: e.target.type === 'checkbox' ? e.target.checked : e.target.value }));
  const inp = { width: '100%', padding: '10px 12px', border: '1px solid var(--border)', borderRadius: 10, background: 'var(--surface-2)', color: 'var(--text)', font: 'inherit', marginBottom: 10 };
  return (
    <Modal
      title={acc.id ? 'Modifier le compte' : 'Nouveau compte'}
      sub={acc.login || 'Créer un utilisateur'}
      onClose={onClose}
      footer={
        <>
          <button className="btn btn-ghost" onClick={onClose}>Annuler</button>
          <button className="btn btn-primary" onClick={() => onSave(f)}>Enregistrer</button>
        </>
      }
    >
      <label className="cell-sub">Identifiant</label>
      <input style={inp} value={f.login} onChange={upd('login')} disabled={!!acc.id} />
      <label className="cell-sub">Nom complet</label>
      <input style={inp} value={f.fullName} onChange={upd('fullName')} />
      <label className="cell-sub">Email</label>
      <input style={inp} value={f.email} onChange={upd('email')} />
      <label className="cell-sub">Téléphone</label>
      <input style={inp} value={f.phone} onChange={upd('phone')} />
      <label className="cell-sub">Rôle</label>
      <select style={inp} value={f.role} onChange={upd('role')}>
        {ROLES.map((r) => <option key={r.key} value={r.key}>{r.name}</option>)}
      </select>
      <label className="cell-sub">{acc.id ? 'Nouveau mot de passe (laisser vide pour conserver)' : 'Mot de passe'}</label>
      <input style={inp} type="password" value={f.password} onChange={upd('password')} />
      <label style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
        <input type="checkbox" checked={!!f.active} onChange={upd('active')} /> Compte actif
      </label>
    </Modal>
  );
}
