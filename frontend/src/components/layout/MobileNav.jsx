// Bottom navigation for small screens (first 5 visible modules).
import { NavLink } from 'react-router-dom';
import { MODULES } from '../../lib/constants.js';
import { useAuth } from '../../auth/AuthContext.jsx';
import { NavIcon } from '../Icons.jsx';

export default function MobileNav() {
  const { can } = useAuth();
  const items = MODULES.filter((m) => !m.navHidden && can(m.key, 'view')).slice(0, 5);
  return (
    <nav className="mobile-nav">
      {items.map((m) => (
        <NavLink
          key={m.key}
          to={m.path}
          end={m.path === '/'}
          className={({ isActive }) => `mn-item${isActive ? ' active' : ''}`}
        >
          <NavIcon name={m.key} size={21} />
          <span>{m.label.split(' ')[0]}</span>
        </NavLink>
      ))}
    </nav>
  );
}
