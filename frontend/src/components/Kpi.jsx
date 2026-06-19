// KPI cards (ported from ClienTara.html). Optional onClick for help/drilldown.
import { nf } from '../lib/format.js';
import { IconTrendUp, IconTrendDn, IconCash } from './Icons.jsx';

export function KpiCard({ tone = 'blue', icon, val, lbl, sub, onClick }) {
  return (
    <div className="card kpi" onClick={onClick} style={onClick ? { cursor: 'pointer' } : undefined}>
      <div className="kpi-top">
        <div className={`kpi-ic ${tone}`}>{icon}</div>
      </div>
      <div className="kpi-val">{typeof val === 'number' ? nf.format(val) : val}</div>
      <div className="kpi-lbl">{lbl}</div>
      {sub ? <div className="kpi-sub">{sub}</div> : null}
    </div>
  );
}

// Fused KPI: a count + its associated monetary amount.
export function KpiDual({ tone = 'blue', icon, number, lbl, amount, sub, onClick }) {
  const neg = amount < 0;
  const amt = nf.format(Math.round(Math.abs(amount)));
  return (
    <div className="card kpi" onClick={onClick} style={onClick ? { cursor: 'pointer' } : undefined}>
      <div className="kpi-top">
        <div className={`kpi-ic ${tone}`}>{icon}</div>
      </div>
      <div className="kpi-val">{typeof number === 'number' ? nf.format(number) : number}</div>
      <div className="kpi-lbl">{lbl}</div>
      <div className={`kpi-amt${neg ? ' neg' : ''}`}>
        {neg ? '−' : ''}
        {amt}
        <span className="kpi-unit">Ar</span>
      </div>
      {sub ? <div className="kpi-sub">{sub}</div> : null}
    </div>
  );
}

const CA_ICON = { green: IconTrendUp, red: IconTrendDn, blue: IconCash };

export function CaCard({ tone = 'blue', lbl, val, sub, onClick }) {
  const Icon = CA_ICON[tone] || IconCash;
  return (
    <div
      className="card kpi kpi-money"
      onClick={onClick}
      style={onClick ? { cursor: 'pointer' } : undefined}
    >
      <div className="kpi-top">
        <div className={`kpi-ic ${tone}`}>
          <Icon size={22} />
        </div>
      </div>
      <div className="kpi-val">
        {nf.format(Math.round(val))}
        <span className="kpi-unit">Ar</span>
      </div>
      <div className="kpi-lbl">{lbl}</div>
      {sub ? <div className="kpi-sub">{sub}</div> : null}
    </div>
  );
}

// Retention-by-technology table (shared by Dashboard + Rapports).
export function TechTable({ rows }) {
  return (
    <div className="tbl-wrap" style={{ marginTop: 12 }}>
      <table className="tbl">
        <thead>
          <tr>
            <th>Technologie</th>
            <th>Demandes de résiliation</th>
            <th>Retenus</th>
            <th>Perdus</th>
            <th>Taux rétention</th>
          </tr>
        </thead>
        <tbody>
          {rows.map((r) => (
            <tr className="norow" key={r.tech}>
              <td className="cell-strong">{r.tech}</td>
              <td>{r.dem}</td>
              <td>
                <span className="badge b-success">{r.retenus}</span>
              </td>
              <td>
                <span className="badge b-danger">{r.perdus}</span>
              </td>
              <td className="cell-strong">{r.taux}%</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
