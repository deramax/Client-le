// Full notifications history with mark-all-read. Items come from DataContext.
import { useNavigate } from 'react-router-dom';
import { useData } from '../data/DataContext.jsx';
import Empty from '../components/Empty.jsx';
import { IconClock, IconExit, IconShield, IconDoc } from '../components/Icons.jsx';
import { fmtDate } from '../lib/format.js';

const TYPE_ICON = { red: IconClock, amber: IconExit, green: IconShield, blue: IconDoc };

export default function Notifications() {
  const { notifs, markAllRead } = useData();
  const navigate = useNavigate();

  return (
    <div className="card">
      <div className="card-h">
        <div><h3>Toutes les notifications</h3><p>{notifs.unread} non lue(s) sur {notifs.items.length}</p></div>
        <button className="btn btn-sm btn-ghost" onClick={() => markAllRead()}>Tout marquer lu</button>
      </div>
      <div className="np-list" style={{ maxHeight: 'none' }}>
        {notifs.items.length ? (
          notifs.items.map((n) => {
            const Icon = TYPE_ICON[n.type] || IconDoc;
            return (
              <div
                key={n.id}
                className={`notif${n.read ? '' : ' unread'}`}
                style={{ cursor: n.did ? 'pointer' : 'default' }}
                onClick={() => n.did && navigate('/demandes?open=' + encodeURIComponent(n.did))}
              >
                <div className={`notif-ic ni-${n.type || 'blue'}`}><Icon size={16} /></div>
                <div className="notif-main">
                  <div className="notif-t">{n.title}</div>
                  <div className="notif-m">{n.body}</div>
                  <div className="notif-d">{fmtDate(n.ts)}</div>
                </div>
              </div>
            );
          })
        ) : (
          <Empty>Aucune notification.</Empty>
        )}
      </div>
    </div>
  );
}
