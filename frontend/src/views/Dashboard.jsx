// Dashboard: KPI cards, monthly charts, retention-by-tech. Computes from the
// demandes list (same business logic as the legacy app) with period + filters.
import { useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Bar, Line } from 'react-chartjs-2';
import { useData } from '../data/DataContext.jsx';
import { FilterBar, PeriodFilter } from '../components/Filters.jsx';
import { KpiDual, TechTable } from '../components/Kpi.jsx';
import { ActionBadge, DecisionBadge } from '../components/Badges.jsx';
import Avatar from '../components/Avatar.jsx';
import {
  IconExit, IconShield, IconTrendDn, IconDoc,
} from '../components/Icons.jsx';
import {
  kpis, retentionStats, resilByTech, monthlySeries, groupCount,
  isDemandeResil, isPending, montAncien,
} from '../lib/demande.js';
import { applyFilters, applyPeriodFilter, EMPTY_FILTERS } from '../lib/period.js';
import { fmtDate, fmtMonth, money } from '../lib/format.js';
import { baseOptions, themeColors } from '../lib/charts.js';

export default function Dashboard() {
  const { demandes, loaded } = useData();
  const navigate = useNavigate();
  const [period, setPeriod] = useState({ filter: 'all', start: null, end: null });
  const [filters, setFilters] = useState(EMPTY_FILTERS);

  const list = useMemo(
    () => applyFilters(applyPeriodFilter(demandes, period), filters),
    [demandes, period, filters]
  );

  const k = useMemo(() => kpis(list), [list]);
  const rf = useMemo(() => retentionStats(list), [list]);
  const techR = useMemo(() => resilByTech(list), [list]);
  const ser = useMemo(() => monthlySeries(list), [list]);
  const motifs = useMemo(() => groupCount(list, 'Motif').slice(0, 6), [list]);
  const recent = useMemo(
    () =>
      [...list]
        .sort((a, b) => (b['Date de réception'] || '').localeCompare(a['Date de réception'] || ''))
        .slice(0, 7),
    [list]
  );

  const demResil = useMemo(() => list.filter(isDemandeResil), [list]);
  const enJeu = demResil.reduce((s, d) => s + montAncien(d), 0);
  const enAttente = demResil.filter(isPending).reduce((s, d) => s + montAncien(d), 0);
  const maxMotif = Math.max(...motifs.map((m) => m[1]), 1);

  const colors = themeColors();
  const labels = ser.months.map(fmtMonth);

  const onFilter = (k2, v) => setFilters((s) => ({ ...s, [k2]: v }));

  return (
    <div>
      <PeriodFilter period={period} setPeriod={setPeriod} />
      <FilterBar filters={filters} onChange={onFilter} onReset={() => setFilters(EMPTY_FILTERS)} />

      {!loaded && <div className="card card-pad">Chargement…</div>}

      <div className="grid g-kpi mb">
        <KpiDual tone="amber" icon={<IconExit size={22} />} number={rf.dem} lbl="Demandes de résiliation" amount={enJeu} sub="Montant en jeu — à risque" />
        <KpiDual tone="green" icon={<IconShield size={22} />} number={rf.retenus} lbl={`Clients retenus · ${rf.taux}% de rétention`} amount={rf.caSauve} sub="Montant sauvegardé / mois" />
        <KpiDual tone="red" icon={<IconTrendDn size={22} />} number={rf.perdus} lbl="Clients résiliés" amount={rf.caPerdu} sub="Montant perdu / mois" />
        <KpiDual tone="blue" icon={<IconDoc size={22} />} number={k.total} lbl={`Requêtes reçues · ${k.pending} en attente`} amount={enAttente} sub="Montant en attente de décision" />
      </div>

      <div className="grid g-2 mb">
        <div className="card">
          <div className="card-h">
            <div>
              <h3>Évolution mensuelle des requêtes</h3>
              <p>Requêtes reçues par mois</p>
            </div>
          </div>
          <div className="card-pad">
            <div className="chart-box">
              <Line
                data={{
                  labels,
                  datasets: [
                    {
                      label: 'Requêtes',
                      data: ser.months.map((m) => ser.recu[m]),
                      borderColor: colors.primary,
                      backgroundColor: colors.primary + '22',
                      fill: true,
                      tension: 0.35,
                      pointRadius: 3,
                      pointBackgroundColor: colors.primary,
                      borderWidth: 2.5,
                    },
                  ],
                }}
                options={baseOptions({ legend: false })}
              />
            </div>
          </div>
        </div>

        <div className="card">
          <div className="card-h">
            <div>
              <h3>Demandes de résiliation par technologie</h3>
              <p>Retenus vs perdus, et taux de rétention</p>
            </div>
          </div>
          <div className="card-pad">
            {techR.length ? (
              <>
                <div className="chart-box">
                  <Bar
                    data={{
                      labels: techR.map((t) => t.tech),
                      datasets: [
                        { label: 'Retenus', data: techR.map((t) => t.retenus), backgroundColor: colors.accent, borderRadius: 5, maxBarThickness: 46, stack: 'r' },
                        { label: 'Perdus', data: techR.map((t) => t.perdus), backgroundColor: colors.danger, borderRadius: 5, maxBarThickness: 46, stack: 'r' },
                      ],
                    }}
                    options={{
                      ...baseOptions({ legend: true }),
                      scales: {
                        x: { stacked: true, grid: { display: false }, border: { display: false } },
                        y: { stacked: true, beginAtZero: true, grid: { color: colors.grid }, border: { display: false } },
                      },
                    }}
                  />
                </div>
                <TechTable rows={techR} />
              </>
            ) : (
              <div className="empty">Aucune demande de résiliation sur la période</div>
            )}
          </div>
        </div>
      </div>

      <div className="card mb">
        <div className="card-h">
          <div>
            <h3>Évolution du chiffre d'affaires</h3>
            <p>CA résiliés vs CA retenus par mois (Ar)</p>
          </div>
        </div>
        <div className="card-pad">
          <div className="chart-box">
            <Bar
              data={{
                labels,
                datasets: [
                  { label: 'CA Retenus', data: ser.months.map((m) => ser.ret[m]), backgroundColor: colors.accent, borderRadius: 5, maxBarThickness: 22 },
                  { label: 'CA Résiliés', data: ser.months.map((m) => ser.res[m]), backgroundColor: colors.danger, borderRadius: 5, maxBarThickness: 22 },
                ],
              }}
              options={baseOptions({ legend: true, moneyAxis: true })}
            />
          </div>
        </div>
      </div>

      <div className="grid g-2 mb">
        <div className="card">
          <div className="card-h">
            <div>
              <h3>Requêtes récentes</h3>
              <p>Dernières demandes reçues</p>
            </div>
            <button className="btn btn-sm btn-ghost" onClick={() => navigate('/demandes')}>
              Tout voir →
            </button>
          </div>
          <div className="tbl-wrap">
            <table className="tbl">
              <thead>
                <tr>
                  <th>Client</th>
                  <th>Site</th>
                  <th>Action</th>
                  <th>Statut</th>
                  <th>Date</th>
                </tr>
              </thead>
              <tbody>
                {recent.map((d) => (
                  <tr key={d.id} onClick={() => navigate('/demandes?open=' + encodeURIComponent(d.id))}>
                    <td>
                      <div className="av-row">
                        <Avatar name={d.Nom_Client} />
                        <div>
                          <div className="cell-strong" style={{ maxWidth: 200, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                            {d.Nom_Client}
                          </div>
                          <div className="cell-sub">Réf {d.Refnum}</div>
                        </div>
                      </div>
                    </td>
                    <td>{d.Site}</td>
                    <td>
                      <ActionBadge action={d.Action} />
                    </td>
                    <td>
                      <DecisionBadge d={d} />
                    </td>
                    <td className="cell-sub">{fmtDate(d['Date de réception'])}</td>
                  </tr>
                ))}
                {!recent.length && (
                  <tr className="norow">
                    <td colSpan={5} className="cell-sub" style={{ padding: 18 }}>
                      Aucune requête.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>

        <div className="card">
          <div className="card-h">
            <div>
              <h3>Motifs principaux</h3>
              <p>Raisons des requêtes</p>
            </div>
          </div>
          <div className="card-pad">
            <div className="bars">
              {motifs.map((m) => (
                <div className="bar-row" key={m[0]}>
                  <div className="bl">
                    <span>{m[0]}</span>
                    <span className="bv">{m[1]}</span>
                  </div>
                  <div className="bar-track">
                    <div className="bar-fill" style={{ width: Math.round((m[1] / maxMotif) * 100) + '%' }} />
                  </div>
                </div>
              ))}
              {!motifs.length && <div className="cell-sub">Aucune donnée.</div>}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
