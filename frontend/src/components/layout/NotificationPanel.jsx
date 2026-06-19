// Dropdown notification panel (topbar bell). Renders latest items + mark-all-read.
import { useNavigate } from 'react-router-dom';
import { useData } from '../../data/DataContext.jsx';
import { fmtDate } from '../../lib/format.js';
import { IconClock, IconExit, IconShield, IconDoc } from '../Icons.jsx';

const TYPE_ICON = {
  red: IconClock,
  amber: IconExit,
  green: IconShield,
  blue: IconDoc,
};

function NotifItem({ n, onPick }) {
  const Icon = TYPE_ICON[n.type] || IconDoc;
  return (
    <div className={`notif${n.read ? '' : ' unread'}`} onClick={() => onPick(n)}>
      <div className={`notif-ic ni-${n.type || 'blue'}`}>
        <Icon size={16} />
      </div>
      <div className="notif-main">
        <div className="notif-t">{n.title}</div>
        <div className="notif-m">{n.body}</div>
        <div className="notif-d">{fmtDate(n.ts)}</div>
      </div>
    </div>
  );
}

export default function NotificationPanel({ open, onClose }) {
  const { notifs, markAllRead } = useData();
  const navigate = useNavigate();
  if (!open) return null;

  const onPick = () => {
    onClose();
    navigate('/notifications');
  };

  return (
    <div className="notif-panel show" onClick={(e) => e.stopPropagation()}>
      <div className="np-h">
        <h4>Notifications</h4>
        <button className="btn btn-sm btn-ghost" onClick={() => markAllRead()}>
          Tout marquer lu
        </button>
      </div>
      <div className="np-list">
        {notifs.items.length ? (
          notifs.items.slice(0, 12).map((n) => <NotifItem key={n.id} n={n} onPick={onPick} />)
        ) : (
          <div className="sug-empty">Aucune notification</div>
        )}
      </div>
      <div className="np-foot">
        <button className="btn btn-sm btn-ghost" onClick={onPick}>
          Voir tout
        </button>
      </div>
    </div>
  );
}
