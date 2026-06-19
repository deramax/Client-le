// Audit & conformité: the security journal (authentication log) from the API.
import { useEffect, useState } from 'react';
import api from '../api/client.js';
import Empty from '../components/Empty.jsx';
import { fmtAudit } from '../lib/format.js';

function tone(action) {
  const a = (action || '').toLowerCase();
  if (a.includes('échec') || a.includes('refus')) return 'b-danger';
  if (a.includes('réussie') || a.includes('création') || a.includes('activation')) return 'b-success';
  if (a.includes('déconnexion')) return 'b-neutral';
  return 'b-info';
}

export default function Audit() {
  const [rows, setRows] = useState(null);
  const [error, setError] = useState('');

  useEffect(() => {
    let alive = true;
    api
      .get('/audit/')
      .then((d) => alive && setRows(Array.isArray(d) ? d : []))
      .catch((e) => alive && setError(e.message || 'Lecture impossible'));
    return () => {
      alive = false;
    };
  }, []);

  return (
    <div className="card">
      <div className="card-h">
        <div><h3>Journal d'audit</h3><p>Connexions, déconnexions et événements de sécurité</p></div>
      </div>
      <div className="tbl-wrap">
        <table className="tbl">
          <thead>
            <tr><th>Événement</th><th>Identifiant</th><th>Appareil</th><th>Adresse IP</th><th>Horodatage</th></tr>
          </thead>
          <tbody>
            {(rows || []).map((r, i) => (
              <tr className="norow" key={i}>
                <td><span className={`badge ${tone(r.action)}`}>{r.action}</span></td>
                <td className="cell-strong">{r.login}</td>
                <td>{r.device || '—'}</td>
                <td className="cell-sub">{r.ip || '—'}</td>
                <td className="cell-sub">{fmtAudit(r.ts)}</td>
              </tr>
            ))}
            {rows && !rows.length && (
              <tr className="norow"><td colSpan={5} style={{ padding: 0 }}><Empty>{error || 'Aucun événement.'}</Empty></td></tr>
            )}
            {!rows && !error && (
              <tr className="norow"><td colSpan={5} className="cell-sub" style={{ padding: 16 }}>Chargement…</td></tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}
