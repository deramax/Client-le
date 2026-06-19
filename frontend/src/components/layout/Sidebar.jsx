// Persistent left sidebar: logo + nav items (permission-gated) + footer role.
import { NavLink } from 'react-router-dom';
import { MODULES, roleByKey } from '../../lib/constants.js';
import { useAuth } from '../../auth/AuthContext.jsx';
import { useData } from '../../data/DataContext.jsx';
import { NavIcon, IconChevron } from '../Icons.jsx';
import logo from '../../assets/clientara-logo.png';
import mark from '../../assets/clientara-mark.png';

export default function Sidebar({ collapsed, onToggleCollapse, mobileOpen, onCloseMobile }) {
  const { user, can } = useAuth();
  const { demandes, notifs } = useData();

  const visible = MODULES.filter((m) => !m.navHidden && can(m.key, 'view'));
  // Split nav into the main group and the "Administration" group (parametres).
  const adminKeys = ['parametres'];
  const mainItems = visible.filter((m) => !adminKeys.includes(m.key));
  const adminItems = visible.filter((m) => adminKeys.includes(m.key));

  const pillFor = (m) =>
    m.key === 'visualisation'
      ? demandes.length
      : m.key === 'notifications'
      ? notifs.unread
      : 0;

  const renderItem = (m) => {
    const pill = pillFor(m);
    return (
      <NavLink
        key={m.key}
        to={m.path}
        end={m.path === '/'}
        className={({ isActive }) => `nav-item${isActive ? ' active' : ''}`}
        data-label={m.label}
        onClick={onCloseMobile}
      >
        <NavIcon name={m.key} />
        <span className="nav-lbl">{m.label}</span>
        {pill ? <span className="pill">{pill}</span> : null}
      </NavLink>
    );
  };

  return (
    <aside className={`sidebar${collapsed ? ' collapsed' : ''}${mobileOpen ? ' open' : ''}`} id="sidebar">
      <div className="side-brand">
        <img
          className="logo-badge"
          src={collapsed ? mark : logo}
          alt="ClienTara"
          style={{ height: 40, width: 'auto' }}
        />
        {!collapsed && (
          <div className="brand-txt">
            <div className="bt">ClienTara</div>
            <div className="bs">Fidélisation client</div>
          </div>
        )}
        <button
          className="side-collapse"
          onClick={onToggleCollapse}
          title={collapsed ? 'Déplier le menu' : 'Replier le menu'}
          aria-label="Replier le menu"
        >
          <IconChevron size={17} sw={2} />
        </button>
      </div>

      <nav className="side-nav">
        <div className="nav-section">Navigation</div>
        {mainItems.map(renderItem)}
        {adminItems.length > 0 && <div className="nav-section">Administration</div>}
        {adminItems.map(renderItem)}
      </nav>

      <div className="side-foot">
        <div className="role">
          <span className="online-dot" />
          <span>
            {user ? `${user.fullName} · ${user.roleName || roleByKey(user.role).name}` : 'Administration'}
          </span>
        </div>
      </div>
    </aside>
  );
}
