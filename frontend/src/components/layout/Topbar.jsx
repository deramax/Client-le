// Top bar: hamburger (mobile), page title/sub, global search w/ suggestions,
// new-request button, notifications bell, theme toggle, profile, logout.
import { useEffect, useMemo, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../auth/AuthContext.jsx';
import { useData } from '../../data/DataContext.jsx';
import { useTheme } from '../../theme/ThemeContext.jsx';
import { useToast } from '../Toast.jsx';
import { norm, fmtDate } from '../../lib/format.js';
import {
  IconMenu, IconSearch, IconBell, IconTheme, IconLogout, IconUser, IconDoc, IconPlus,
} from '../Icons.jsx';
import NotificationPanel from './NotificationPanel.jsx';

function buildSearchIndex(demandes) {
  const idx = [];
  const seen = new Set();
  demandes.forEach((d) => {
    const key = 'c:' + d.Refnum;
    if (!seen.has(key)) {
      seen.add(key);
      idx.push({
        type: 'client',
        label: d.Nom_Client,
        sub: 'Réf ' + d.Refnum,
        ref: d.Refnum,
        hay: norm(d.Nom_Client + ' ' + d.Refnum),
      });
    }
    idx.push({
      type: 'req',
      label: d.Nom_Client,
      sub: `${d.Requête_client || ''} · ${d.Ancien_produit || ''} · ${fmtDate(d['Date de réception'])}`,
      id: d.id,
      hay: norm([d.Nom_Client, d.Refnum, d.Ancien_produit, d.Nouveau_produit, d.Motif, d.id].join(' ')),
    });
  });
  return idx;
}

export default function Topbar({ title, sub, onToggleSidebar }) {
  const { user, can, logout } = useAuth();
  const { demandes, notifs } = useData();
  const { cycleTheme, meta, theme } = useTheme();
  const toast = useToast();
  const navigate = useNavigate();

  const [q, setQ] = useState('');
  const [showSug, setShowSug] = useState(false);
  const [notifOpen, setNotifOpen] = useState(false);
  const blurTimer = useRef(null);

  const index = useMemo(() => buildSearchIndex(demandes), [demandes]);
  const matches = useMemo(() => {
    const nq = norm(q);
    if (!nq) return [];
    return index.filter((it) => it.hay.includes(nq)).slice(0, 8);
  }, [q, index]);

  // Close notif panel on outside click.
  useEffect(() => {
    if (!notifOpen) return undefined;
    const handler = (e) => {
      if (!e.target.closest('.notif-panel') && !e.target.closest('.iconbtn')) setNotifOpen(false);
    };
    document.addEventListener('click', handler);
    return () => document.removeEventListener('click', handler);
  }, [notifOpen]);

  const pick = (m) => {
    setShowSug(false);
    setQ('');
    if (m.type === 'client') navigate('/clients/' + encodeURIComponent(m.ref));
    else navigate('/demandes?open=' + encodeURIComponent(m.id));
  };

  const profileInitials = (user?.fullName || '?')
    .trim()
    .split(/\s+/)
    .map((p) => p[0])
    .slice(0, 2)
    .join('')
    .toUpperCase();

  return (
    <header className="topbar">
      <button className="hamb" onClick={onToggleSidebar} aria-label="Menu">
        <IconMenu size={24} />
      </button>
      <div className="page-h">
        <h1>{title}</h1>
        <p>{sub}</p>
      </div>
      <div className="top-spacer" />

      <div className="search">
        <IconSearch className="si" size={17} />
        <input
          type="text"
          placeholder="Rechercher un client, réf, produit…"
          value={q}
          autoComplete="off"
          onChange={(e) => {
            setQ(e.target.value);
            setShowSug(true);
          }}
          onFocus={() => q && setShowSug(true)}
          onBlur={() => {
            blurTimer.current = setTimeout(() => setShowSug(false), 180);
          }}
          onKeyDown={(e) => {
            if (e.key === 'Enter') {
              setShowSug(false);
              navigate('/demandes?q=' + encodeURIComponent(q));
              setQ('');
            }
          }}
        />
        <div className={`suggest${showSug && q ? ' show' : ''}`}>
          {matches.length ? (
            matches.map((m, i) => (
              <div
                key={i}
                className="sug-item"
                onMouseDown={() => {
                  clearTimeout(blurTimer.current);
                  pick(m);
                }}
              >
                <div className="sug-ic">{m.type === 'client' ? <IconUser size={16} /> : <IconDoc size={16} />}</div>
                <div className="sug-main">
                  <div className="sug-t">{m.label}</div>
                  <div className="sug-s">{m.sub}</div>
                </div>
                <div className="sug-tag">{m.type === 'client' ? 'Client' : 'Requête'}</div>
              </div>
            ))
          ) : (
            <div className="sug-empty">Aucun résultat</div>
          )}
        </div>
      </div>

      {can('visualisation', 'create') && (
        <button className="btn btn-primary" onClick={() => navigate('/demandes?new=1')}>
          <IconPlus size={16} />
          <span className="nr-label">Nouvelle requête</span>
        </button>
      )}

      <button
        className="iconbtn"
        onClick={() => setNotifOpen((v) => !v)}
        title="Notifications"
        aria-label="Notifications"
      >
        <IconBell size={18} />
        {notifs.unread ? <span className="dot">{notifs.unread > 99 ? '99+' : notifs.unread}</span> : null}
      </button>

      <button
        className="iconbtn"
        onClick={() => {
          cycleTheme();
          toast('Thème : ' + (meta[theme]?.name || theme));
        }}
        title="Changer de thème"
        aria-label="Changer de thème"
      >
        <IconTheme size={18} />
      </button>

      <button
        className="iconbtn"
        onClick={() => navigate('/parametres')}
        title="Mon profil"
        aria-label="Profil"
        style={{
          overflow: 'hidden',
          backgroundImage: user?.photo ? `url(${user.photo})` : undefined,
          backgroundSize: 'cover',
          backgroundPosition: 'center',
        }}
      >
        {!user?.photo && <span style={{ fontSize: 12, fontWeight: 700 }}>{profileInitials}</span>}
      </button>

      <button className="iconbtn" onClick={() => logout()} title="Déconnexion" aria-label="Déconnexion">
        <IconLogout size={18} />
      </button>

      <NotificationPanel open={notifOpen} onClose={() => setNotifOpen(false)} />
    </header>
  );
}
