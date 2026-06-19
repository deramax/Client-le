// Clients directory + per-client history timeline. Supports /clients/:refnum.
import { useEffect, useMemo, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { useData } from '../data/DataContext.jsx';
import Modal from '../components/Modal.jsx';
import Avatar from '../components/Avatar.jsx';
import Empty from '../components/Empty.jsx';
import { ActionBadge, DecisionBadge } from '../components/Badges.jsx';
import { IconSearch } from '../components/Icons.jsx';
import { norm, fmtDate, money } from '../lib/format.js';
import { isResilie, montAncien, montNouveau } from '../lib/demande.js';

const PAGE_SIZE = 30;

export default function Clients() {
  const { clients, demandes, loaded } = useData();
  const navigate = useNavigate();
  const { refnum } = useParams();

  const [search, setSearch] = useState('');
  const [page, setPage] = useState(1);

  // Aggregate per-refnum: name + request count + last date.
  const index = useMemo(() => {
    const map = new Map();
    clients.forEach((c) => map.set(c.Refnum, { refnum: c.Refnum, nom: c.Nom_Client, count: 0, last: '' }));
    demandes.forEach((d) => {
      const cur = map.get(d.Refnum) || { refnum: d.Refnum, nom: d.Nom_Client, count: 0, last: '' };
      cur.count += 1;
      if ((d['Date de réception'] || '') > cur.last) cur.last = d['Date de réception'] || '';
      if (!cur.nom) cur.nom = d.Nom_Client;
      map.set(d.Refnum, cur);
    });
    return [...map.values()].sort((a, b) => (a.nom || '').localeCompare(b.nom || ''));
  }, [clients, demandes]);

  const filtered = useMemo(() => {
    const nq = norm(search);
    if (!nq) return index;
    return index.filter((c) => norm(c.nom + ' ' + c.refnum).includes(nq));
  }, [index, search]);

  useEffect(() => setPage(1), [search]);

  const totalPages = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE));
  const curPage = Math.min(page, totalPages);
  const slice = filtered.slice((curPage - 1) * PAGE_SIZE, curPage * PAGE_SIZE);

  const selected = refnum ? index.find((c) => c.refnum === refnum) : null;
  const clientDemandes = useMemo(
    () =>
      demandes
        .filter((d) => d.Refnum === refnum)
        .sort((a, b) => (b['Date de réception'] || '').localeCompare(a['Date de réception'] || '')),
    [demandes, refnum]
  );

  return (
    <div>
      <div className="search" style={{ position: 'relative', marginBottom: 14, maxWidth: 420 }}>
        <IconSearch className="si" size={17} />
        <input
          type="text"
          placeholder="Rechercher un client (nom ou réf)…"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          style={{ width: '100%' }}
        />
      </div>

      <div className="card">
        <div className="tbl-wrap">
          <table className="tbl">
            <thead>
              <tr>
                <th>Client</th>
                <th>Référence</th>
                <th>Requêtes</th>
                <th>Dernière activité</th>
              </tr>
            </thead>
            <tbody>
              {slice.map((c) => (
                <tr key={c.refnum} style={{ cursor: 'pointer' }} onClick={() => navigate('/clients/' + encodeURIComponent(c.refnum))}>
                  <td>
                    <div className="av-row">
                      <Avatar name={c.nom} />
                      <div className="cell-strong" style={{ maxWidth: 280, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                        {c.nom || '(sans nom)'}
                      </div>
                    </div>
                  </td>
                  <td>{c.refnum}</td>
                  <td><span className="badge b-info">{c.count}</span></td>
                  <td className="cell-sub">{c.last ? fmtDate(c.last) : '—'}</td>
                </tr>
              ))}
              {!slice.length && (
                <tr className="norow">
                  <td colSpan={4} style={{ padding: 0 }}>
                    <Empty>{loaded ? 'Aucun client trouvé.' : 'Chargement…'}</Empty>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {filtered.length > PAGE_SIZE && (
          <div className="pager">
            <span className="pinfo">
              {(curPage - 1) * PAGE_SIZE + 1}–{Math.min(curPage * PAGE_SIZE, filtered.length)} sur {filtered.length}
            </span>
            <span style={{ display: 'flex', gap: 8 }}>
              <button className="btn btn-sm btn-ghost" disabled={curPage <= 1} onClick={() => setPage(curPage - 1)}>← Précédent</button>
              <span className="pinfo">Page {curPage} / {totalPages}</span>
              <button className="btn btn-sm btn-ghost" disabled={curPage >= totalPages} onClick={() => setPage(curPage + 1)}>Suivant →</button>
            </span>
          </div>
        )}
      </div>

      {refnum && (
        <Modal
          title={selected ? selected.nom : 'Client'}
          sub={`Réf ${refnum} · ${clientDemandes.length} requête(s)`}
          size="wide"
          onClose={() => navigate('/clients')}
          footer={<button className="btn btn-ghost" onClick={() => navigate('/clients')}>Fermer</button>}
        >
          {clientDemandes.length ? (
            <div className="timeline">
              {clientDemandes.map((d) => (
                <div className="tl-item" key={d.id}>
                  <span className={`tl-dot ${isResilie(d) ? 'red' : 'green'}`} />
                  <div className="tl-head">
                    <ActionBadge action={d.Action} />
                    <DecisionBadge d={d} />
                    <span className="tl-date">{fmtDate(d['Date de réception'])}</span>
                    <button
                      className="btn btn-sm btn-ghost"
                      style={{ marginLeft: 'auto' }}
                      onClick={() => navigate('/demandes?open=' + encodeURIComponent(d.id))}
                    >
                      Ouvrir
                    </button>
                  </div>
                  <div className="tl-body">
                    <span className="tg">Requête : <b>{d.Requête_client || '—'}</b></span>
                    <span className="tg">Motif : <b>{d.Motif || '—'}</b></span>
                    <span className="tg">Produit : <b>{d.Ancien_produit || '—'}</b></span>
                    {montAncien(d) ? <span className="tg">Mensualité : <b>{money(montAncien(d))}</b></span> : null}
                    {d.Nouveau_produit ? <span className="tg">Nouveau : <b>{d.Nouveau_produit}</b> ({money(montNouveau(d))})</span> : null}
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <Empty>Aucune requête enregistrée pour ce client.</Empty>
          )}
        </Modal>
      )}
    </div>
  );
}
