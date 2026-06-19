// Shared filter bar + period filter UI (ported from ClienTara.html).
import { useData } from '../data/DataContext.jsx';
import {
  availableYears, allMonthsDesc, dataDateBounds, periodLabel,
} from '../lib/period.js';
import { MOIS_FR } from '../lib/format.js';

const selSty = {
  padding: '8px 12px',
  border: '1px solid var(--border)',
  borderRadius: 10,
  background: 'var(--surface)',
  color: 'var(--text)',
  font: 'inherit',
  fontSize: 13,
  cursor: 'pointer',
};

// Standard module filter row (Site/Agent/Tech/Type/Action/Statut).
export function FilterBar({ filters, onChange, onReset }) {
  const { ref } = useData();
  const sel = (key, label, arr) => (
    <select value={filters[key]} onChange={(e) => onChange(key, e.target.value)}>
      <option value="">{label} : tous</option>
      {arr.map((v) => (
        <option key={v} value={v}>
          {v}
        </option>
      ))}
    </select>
  );
  return (
    <div className="filters" style={{ background: 'var(--surface)', padding: 12, borderRadius: 11, marginBottom: 14 }}>
      {sel('site', 'Site', ref.Sites)}
      {sel('agent', 'Agent', ref.Agents)}
      {sel('tech', 'Tech', ref.Technologies)}
      {sel('requete', 'Type', ref.Requetes)}
      {sel('action', 'Action', ref.Actions)}
      {sel('niveau', 'Statut', ref.Niveaux)}
      <button className="btn btn-sm btn-ghost" onClick={onReset}>
        Réinitialiser
      </button>
    </div>
  );
}

// Period selector: presets + year/month dropdowns + custom range.
export function PeriodFilter({ period, setPeriod }) {
  const { demandes } = useData();
  const years = availableYears(demandes);
  const months = allMonthsDesc(demandes);
  const bounds = dataDateBounds(demandes);
  const { filter } = period;
  const curY = filter.indexOf('y:') === 0 ? filter.slice(2) : '';
  const curM = filter.indexOf('m:') === 0 ? filter.slice(2) : '';
  const isC = filter === 'custom';

  const seg = (v, lbl) => (
    <button className={filter === v ? 'active' : ''} onClick={() => setPeriod({ ...period, filter: v })}>
      {lbl}
    </button>
  );

  const onCustom = (which, value) => {
    const next = { ...period, [which]: value || null };
    if (next.start && next.end) next.filter = 'custom';
    setPeriod(next);
  };

  return (
    <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap', alignItems: 'center', marginBottom: 14 }}>
      <div className="seg">
        {seg('all', 'Tout')}
        {seg('week', 'Cette semaine')}
        {seg('month', 'Ce mois')}
        {seg('year', 'Cette année')}
        {seg('7d', '7 j')}
        {seg('30d', '30 j')}
      </div>
      <select
        style={selSty}
        value={curY}
        onChange={(e) => setPeriod({ ...period, filter: e.target.value ? 'y:' + e.target.value : 'all' })}
      >
        <option value="">Année précise…</option>
        {years.map((y) => (
          <option key={y} value={y}>
            {y}
          </option>
        ))}
      </select>
      <select
        style={selSty}
        value={curM}
        onChange={(e) => setPeriod({ ...period, filter: e.target.value ? 'm:' + e.target.value : 'all' })}
      >
        <option value="">Mois précis…</option>
        {months.map((k) => {
          const p = k.split('-');
          return (
            <option key={k} value={k}>
              {MOIS_FR[+p[1] - 1]} {p[0]}
            </option>
          );
        })}
      </select>
      <span style={{ display: 'inline-flex', gap: 7, alignItems: 'center', fontSize: 12.5, color: 'var(--text-3)' }}>
        Du
        <input
          type="date"
          value={isC ? period.start || '' : ''}
          min={bounds.mn || ''}
          max={bounds.mx || ''}
          onChange={(e) => onCustom('start', e.target.value)}
          style={{ ...selSty, cursor: 'text' }}
        />
        au
        <input
          type="date"
          value={isC ? period.end || '' : ''}
          min={bounds.mn || ''}
          max={bounds.mx || ''}
          onChange={(e) => onCustom('end', e.target.value)}
          style={{ ...selSty, cursor: 'text' }}
        />
      </span>
      <span style={{ fontSize: 12.5, color: 'var(--text-3)' }}>
        Période : <strong style={{ color: 'var(--text-2)' }}>{periodLabel(period)}</strong>
      </span>
    </div>
  );
}
