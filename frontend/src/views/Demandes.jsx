// Demandes (legacy "visualisation"): searchable, filterable, paginated list of
// requests with detail/edit/create modals and the 4D import flow.
import { useEffect, useMemo, useState } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { useData } from '../data/DataContext.jsx';
import { useAuth } from '../auth/AuthContext.jsx';
import { useToast } from '../components/Toast.jsx';
import api from '../api/client.js';
import { FilterBar } from '../components/Filters.jsx';
import { ActionBadge, DecisionBadge, OutcomeBadge } from '../components/Badges.jsx';
import Avatar from '../components/Avatar.jsx';
import Empty from '../components/Empty.jsx';
import { IconSearch, IconPlus, IconDownload } from '../components/Icons.jsx';
import { applyFilters, EMPTY_FILTERS } from '../lib/period.js';
import { norm, fmtDate } from '../lib/format.js';
import { demandesToCSV, downloadFile } from '../lib/demande.js';
import DemandeDetail from './demandes/DemandeDetail.jsx';
import DemandeForm from './demandes/DemandeForm.jsx';
import FourdImport from './demandes/FourdImport.jsx';

const PAGE_SIZE = 25;

export default function Demandes() {
  const { demandes, loaded, loadDemandes, loadClients } = useData();
  const { can } = useAuth();
  const toast = useToast();
  const navigate = useNavigate();
  const [params, setParams] = useSearchParams();

  const [search, setSearch] = useState(params.get('q') || '');
  const [filters, setFilters] = useState(EMPTY_FILTERS);
  const [page, setPage] = useState(1);

  const [detail, setDetail] = useState(null); // demande object
  const [form, setForm] = useState(null); // {initial, editingId} | null
  const [fourd, setFourd] = useState(false);

  // React to topbar query params (?new, ?open, ?q).
  useEffect(() => {
    if (params.get('new')) {
      setForm({ initial: {}, editingId: null });
      params.delete('new');
      setParams(params, { replace: true });
    }
    const openId = params.get('open');
    if (openId) {
      const d = demandes.find((x) => x.id === openId);
      if (d) setDetail(d);
      params.delete('open');
      setParams(params, { replace: true });
    }
    const q = params.get('q');
    if (q != null) {
      setSearch(q);
      params.delete('q');
      setParams(params, { replace: true });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [params, demandes]);

  const filtered = useMemo(() => {
    const nq = norm(search);
    let list = applyFilters(demandes, filters);
    if (nq) {
      list = list.filter((d) =>
        norm([d.Nom_Client, d.Refnum, d.Ancien_produit, d.Nouveau_produit, d.Motif, d.id].join(' ')).includes(nq)
      );
    }
    return [...list].sort((a, b) => (b['Date de réception'] || '').localeCompare(a['Date de réception'] || ''));
  }, [demandes, filters, search]);

  const totalPages = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE));
  const curPage = Math.min(page, totalPages);
  const slice = filtered.slice((curPage - 1) * PAGE_SIZE, curPage * PAGE_SIZE);

  useEffect(() => setPage(1), [search, filters]);

  const onFilter = (k, v) => setFilters((s) => ({ ...s, [k]: v }));

  const remove = async (d) => {
    if (!window.confirm('Supprimer définitivement cette requête ?')) return;
    try {
      await api.del(`/demandes/${encodeURIComponent(d.id)}/`);
      toast('Requête supprimée');
      setDetail(null);
      await loadDemandes();
    } catch (e) {
      toast(e.message || 'Suppression impossible');
    }
  };

  const cancelResil = async (d) => {
    if (!window.confirm('Annuler la résiliation de cette requête ?')) return;
    try {
      await api.patch(`/demandes/${encodeURIComponent(d.id)}/`, {
        Action: 'Annulation',
        __reason: 'Annulation de la résiliation',
      });
      toast('Résiliation annulée');
      setDetail(null);
      await loadDemandes();
    } catch (e) {
      toast(e.message || 'Action impossible');
    }
  };

  const exportCsv = () => {
    downloadFile(demandesToCSV(filtered), 'clientara-demandes.csv', 'text/csv;charset=utf-8');
  };

  return (
    <div>
      <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap', marginBottom: 14, alignItems: 'center' }}>
        <div className="search" style={{ position: 'relative', flex: 1, minWidth: 240 }}>
          <IconSearch className="si" size={17} />
          <input
            type="text"
            placeholder="Rechercher (nom, réf, produit, motif, ID…)"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            style={{ width: '100%' }}
          />
        </div>
        <button className="btn btn-ghost btn-sm" onClick={exportCsv}>
          <IconDownload size={16} /> Export CSV
        </button>
        {can('visualisation', 'create') && (
          <button className="btn btn-ghost btn-sm" onClick={() => setFourd(true)}>
            Importer depuis 4D
          </button>
        )}
        {can('visualisation', 'create') && (
          <button className="btn btn-primary btn-sm" onClick={() => setForm({ initial: {}, editingId: null })}>
            <IconPlus size={16} /> Nouvelle requête
          </button>
        )}
      </div>

      <FilterBar filters={filters} onChange={onFilter} onReset={() => setFilters(EMPTY_FILTERS)} />

      <div className="card">
        <div className="tbl-wrap">
          <table className="tbl">
            <thead>
              <tr>
                <th>Client</th>
                <th>Site</th>
                <th>Requête</th>
                <th>Action</th>
                <th>Issue</th>
                <th>Statut</th>
                <th>Date</th>
              </tr>
            </thead>
            <tbody>
              {slice.map((d) => (
                <tr key={d.id} onClick={() => setDetail(d)} style={{ cursor: 'pointer' }}>
                  <td>
                    <div className="av-row">
                      <Avatar name={d.Nom_Client} />
                      <div>
                        <div className="cell-strong" style={{ maxWidth: 220, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                          {d.Nom_Client}
                        </div>
                        <div className="cell-sub">Réf {d.Refnum} · {d.id}</div>
                      </div>
                    </div>
                  </td>
                  <td>{d.Site}</td>
                  <td>{d.Requête_client}</td>
                  <td><ActionBadge action={d.Action} /></td>
                  <td><OutcomeBadge d={d} /></td>
                  <td><DecisionBadge d={d} /></td>
                  <td className="cell-sub">{fmtDate(d['Date de réception'])}</td>
                </tr>
              ))}
              {!slice.length && (
                <tr className="norow">
                  <td colSpan={7} style={{ padding: 0 }}>
                    <Empty>{loaded ? 'Aucune requête ne correspond.' : 'Chargement…'}</Empty>
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
              <button className="btn btn-sm btn-ghost" disabled={curPage <= 1} onClick={() => setPage(curPage - 1)}>
                ← Précédent
              </button>
              <span className="pinfo">Page {curPage} / {totalPages}</span>
              <button className="btn btn-sm btn-ghost" disabled={curPage >= totalPages} onClick={() => setPage(curPage + 1)}>
                Suivant →
              </button>
            </span>
          </div>
        )}
      </div>

      {detail && (
        <DemandeDetail
          d={detail}
          onClose={() => setDetail(null)}
          onEdit={(d) => {
            setDetail(null);
            setForm({ initial: d, editingId: d.id });
          }}
          onDelete={remove}
          onCancelResil={cancelResil}
          onOpenClient={(refnum) => {
            setDetail(null);
            navigate('/clients/' + encodeURIComponent(refnum));
          }}
        />
      )}

      {form && (
        <DemandeForm
          initial={form.initial}
          editingId={form.editingId}
          onClose={() => setForm(null)}
          onSaved={() => {
            loadDemandes();
            loadClients();
          }}
        />
      )}

      {fourd && (
        <FourdImport
          onClose={() => setFourd(false)}
          onImport={(prefill) => setForm({ initial: prefill, editingId: null })}
        />
      )}
    </div>
  );
}
