// Analyses: retention KPIs, résiliations by technology, agent performance,
// product/motif breakdown, CA evolution, with client-side CSV exports.
import { useMemo, useState } from 'react';
import { Bar } from 'react-chartjs-2';
import { useData } from '../data/DataContext.jsx';
import { FilterBar, PeriodFilter } from '../components/Filters.jsx';
import { CaCard, TechTable } from '../components/Kpi.jsx';
import { IconDownload } from '../components/Icons.jsx';
import { applyFilters, applyPeriodFilter, EMPTY_FILTERS } from '../lib/period.js';
import {
  retentionStats, resilByTech, agentPerf, resilProductMotif, monthlySeries,
  splitResilRet, demandesToCSV, downloadFile,
} from '../lib/demande.js';
import { money, fmtMonth, nf } from '../lib/format.js';
import { baseOptions, themeColors } from '../lib/charts.js';

export default function Rapports() {
  const { demandes } = useData();
  const [period, setPeriod] = useState({ filter: 'all', start: null, end: null });
  const [filters, setFilters] = useState(EMPTY_FILTERS);

  const list = useMemo(
    () => applyFilters(applyPeriodFilter(demandes, period), filters),
    [demandes, period, filters]
  );

  const rf = useMemo(() => retentionStats(list), [list]);
  const techR = useMemo(() => resilByTech(list), [list]);
  const agents = useMemo(() => agentPerf(list).filter((a) => a.dem > 0), [list]);
  const pm = useMemo(() => resilProductMotif(list), [list]);
  const ser = useMemo(() => monthlySeries(list), [list]);
  const colors = themeColors();

  const exp = (kind) => {
    const { resil, ret } = splitResilRet(list);
    const rows = kind === 'resil' ? resil : ret;
    downloadFile(demandesToCSV(rows), `clientara-${kind}.csv`, 'text/csv;charset=utf-8');
  };

  return (
    <div>
      <PeriodFilter period={period} setPeriod={setPeriod} />
      <FilterBar filters={filters} onChange={(k, v) => setFilters((s) => ({ ...s, [k]: v }))} onReset={() => setFilters(EMPTY_FILTERS)} />

      <div className="grid g-ca mb">
        <CaCard tone="green" lbl={`Montant sauvegardé · ${rf.retenus} retenus`} val={rf.caSauve} sub={`${rf.taux}% de rétention`} />
        <CaCard tone="red" lbl={`Montant perdu · ${rf.perdus} résiliés`} val={rf.caPerdu} sub="Résiliations confirmées" />
        <CaCard tone="blue" lbl="Demandes de résiliation" val={rf.dem} sub="Population à risque" />
      </div>

      <div className="grid g-2e mb">
        <div className="card">
          <div className="card-h">
            <div><h3>Résiliations par technologie</h3><p>Retenus vs perdus</p></div>
            <button className="btn btn-sm btn-ghost" onClick={() => exp('resil')}><IconDownload size={15} /> Résiliés</button>
          </div>
          <div className="card-pad">
            {techR.length ? <TechTable rows={techR} /> : <div className="empty">Aucune donnée.</div>}
          </div>
        </div>

        <div className="card">
          <div className="card-h"><div><h3>CA mensuel</h3><p>Sauvegardé vs perdu (Ar)</p></div></div>
          <div className="card-pad">
            <div className="chart-box">
              <Bar
                data={{
                  labels: ser.months.map(fmtMonth),
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
      </div>

      <div className="card mb">
        <div className="card-h">
          <div><h3>Performance par agent</h3><p>Demandes de résiliation traitées et taux de rétention</p></div>
          <button className="btn btn-sm btn-ghost" onClick={() => exp('ret')}><IconDownload size={15} /> Retenus</button>
        </div>
        <div className="tbl-wrap">
          <table className="tbl">
            <thead>
              <tr><th>Agent</th><th>Demandes</th><th>Retenus</th><th>Perdus</th><th>Taux</th><th>Montant sauvegardé</th></tr>
            </thead>
            <tbody>
              {agents.map((a) => (
                <tr className="norow" key={a.agent}>
                  <td className="cell-strong">{a.agent}</td>
                  <td>{a.dem}</td>
                  <td><span className="badge b-success">{a.retenus}</span></td>
                  <td><span className="badge b-danger">{a.perdus}</span></td>
                  <td className="cell-strong">{a.taux}%</td>
                  <td>{money(a.caSauve)}</td>
                </tr>
              ))}
              {!agents.length && <tr className="norow"><td colSpan={6} className="cell-sub" style={{ padding: 16 }}>Aucune donnée.</td></tr>}
            </tbody>
          </table>
        </div>
      </div>

      <div className="card">
        <div className="card-h"><div><h3>Motifs de résiliation par technologie</h3><p>Résiliations confirmées · {pm.total} au total</p></div></div>
        <div className="tbl-wrap">
          <table className="tbl">
            <thead>
              <tr>
                <th>Technologie</th>
                {pm.motifs.map((m) => <th key={m}>{m}</th>)}
                <th>Total</th>
              </tr>
            </thead>
            <tbody>
              {pm.techList.map((t) => {
                const row = pm.techs[t] || {};
                const total = Object.values(row).reduce((x, y) => x + y, 0);
                return (
                  <tr className="norow" key={t}>
                    <td className="cell-strong">{t}</td>
                    {pm.motifs.map((m) => <td key={m}>{row[m] || 0}</td>)}
                    <td className="cell-strong">{total}</td>
                  </tr>
                );
              })}
              {!pm.techList.length && (
                <tr className="norow"><td colSpan={pm.motifs.length + 2} className="cell-sub" style={{ padding: 16 }}>Aucune résiliation sur la période.</td></tr>
              )}
              {pm.techList.length > 0 && (
                <tr className="norow" style={{ fontWeight: 600 }}>
                  <td className="cell-strong">Total</td>
                  {pm.motifs.map((m) => <td key={m}>{nf.format(pm.motifTotals[m] || 0)}</td>)}
                  <td className="cell-strong">{pm.total}</td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
