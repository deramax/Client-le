// App shell: sidebar + topbar + routed content + mobile nav.
import { useEffect, useState } from 'react';
import { Outlet, useLocation } from 'react-router-dom';
import Sidebar from './Sidebar.jsx';
import Topbar from './Topbar.jsx';
import MobileNav from './MobileNav.jsx';
import { MODULES, PAGE_INFO } from '../../lib/constants.js';

const COLLAPSE_KEY = 'cta_sb_collapsed';

function pageInfoFor(pathname) {
  // Longest-prefix match against module paths.
  let best = null;
  MODULES.forEach((m) => {
    if (m.path === '/' ? pathname === '/' : pathname.startsWith(m.path)) {
      if (!best || m.path.length > best.path.length) best = m;
    }
  });
  const key = best ? best.key : 'dashboard';
  return PAGE_INFO[key] || PAGE_INFO.dashboard;
}

export default function Layout() {
  const location = useLocation();
  const [collapsed, setCollapsed] = useState(
    () => localStorage.getItem(COLLAPSE_KEY) === '1' && window.innerWidth > 760
  );
  const [mobileOpen, setMobileOpen] = useState(false);

  const [title, sub] = pageInfoFor(location.pathname);

  // Close the mobile drawer on route change.
  useEffect(() => {
    setMobileOpen(false);
    if (typeof window !== 'undefined') window.scrollTo(0, 0);
  }, [location.pathname]);

  const toggleCollapse = () => {
    setCollapsed((c) => {
      const next = !c;
      localStorage.setItem(COLLAPSE_KEY, next ? '1' : '0');
      return next;
    });
  };

  return (
    <div className="app">
      <div className={`scrim${mobileOpen ? ' show' : ''}`} onClick={() => setMobileOpen(false)} />
      <Sidebar
        collapsed={collapsed}
        onToggleCollapse={toggleCollapse}
        mobileOpen={mobileOpen}
        onCloseMobile={() => setMobileOpen(false)}
      />
      <div className="main">
        <Topbar title={title} sub={sub} onToggleSidebar={() => setMobileOpen((v) => !v)} />
        <main className="content">
          <Outlet />
        </main>
      </div>
      <MobileNav />
    </div>
  );
}
