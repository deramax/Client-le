// Period filtering helpers (ported from ClienTara.html period filter logic).
import { monthKey, MOIS_FR } from './format.js';

export function availableYears(demandes) {
  const ys = new Set();
  (demandes || []).forEach((d) => {
    const k = monthKey(d['Date de réception']);
    if (k) ys.add(k.slice(0, 4));
  });
  return [...ys].sort().reverse();
}

export function allMonthsDesc(demandes) {
  const set = new Set();
  (demandes || []).forEach((d) => {
    const k = monthKey(d['Date de réception']);
    if (k) set.add(k);
  });
  return [...set].sort().reverse();
}

export function dataDateBounds(demandes) {
  let mn = null,
    mx = null;
  (demandes || []).forEach((d) => {
    const t = (d['Date de réception'] || '').slice(0, 10);
    if (/^\d{4}-\d\d-\d\d$/.test(t)) {
      if (!mn || t < mn) mn = t;
      if (!mx || t > mx) mx = t;
    }
  });
  return { mn, mx };
}

// period = {filter, start, end}
export function periodRange(period) {
  const { filter, start: periodStart, end: periodEnd } = period;
  if (filter === 'all') return null;
  if (filter === 'custom') {
    if (!periodStart || !periodEnd) return null;
    let a = periodStart,
      b = periodEnd;
    if (a > b) {
      const t = a;
      a = b;
      b = t;
    }
    return {
      start: new Date(a + 'T00:00:00').getTime(),
      end: new Date(b + 'T23:59:59.999').getTime(),
    };
  }
  const now = new Date();
  let s, e;
  if (filter.indexOf('y:') === 0) {
    const y = +filter.slice(2);
    s = new Date(y, 0, 1);
    e = new Date(y, 11, 31, 23, 59, 59, 999);
  } else if (filter.indexOf('m:') === 0) {
    const p = filter.slice(2).split('-');
    const y = +p[0],
      m = +p[1];
    s = new Date(y, m - 1, 1);
    e = new Date(y, m, 0, 23, 59, 59, 999);
  } else {
    s = new Date(now);
    if (filter === 'week') s.setDate(now.getDate() - now.getDay());
    else if (filter === 'month') s = new Date(now.getFullYear(), now.getMonth(), 1);
    else if (filter === 'year') s = new Date(now.getFullYear(), 0, 1);
    else if (filter === '7d') s.setDate(now.getDate() - 7);
    else if (filter === '30d') s.setDate(now.getDate() - 30);
    s.setHours(0, 0, 0, 0);
    e = new Date(now);
    e.setHours(23, 59, 59, 999);
  }
  return { start: s.getTime(), end: e.getTime() };
}

export function applyPeriodFilter(list, period) {
  const r = periodRange(period);
  if (!r) return list;
  return list.filter((d) => {
    const t = new Date(d['Date de réception']).getTime();
    return !isNaN(t) && t >= r.start && t <= r.end;
  });
}

export function applyFilters(list, filters) {
  return list.filter((d) => {
    if (filters.site && d.Site !== filters.site) return false;
    if (filters.agent && d.Agent_fidélisation !== filters.agent) return false;
    if (filters.tech && d.Technologie !== filters.tech) return false;
    if (filters.requete && d.Requête_client !== filters.requete) return false;
    if (filters.action && d.Action !== filters.action) return false;
    if (filters.niveau && (d['Niveau décision'] || '') !== filters.niveau) return false;
    return true;
  });
}

function ddmmyyyy(s) {
  const p = (s || '').slice(0, 10).split('-');
  return p.length === 3 ? `${p[2]}/${p[1]}/${p[0]}` : s || '';
}

export function periodLabel(period) {
  const { filter, start: periodStart, end: periodEnd } = period;
  if (filter === 'all') return 'toute la période';
  if (filter === 'week') return 'cette semaine';
  if (filter === 'month') return 'ce mois-ci';
  if (filter === 'year') return 'cette année';
  if (filter === '7d') return 'les 7 derniers jours';
  if (filter === '30d') return 'les 30 derniers jours';
  if (filter.indexOf('y:') === 0) return 'année ' + filter.slice(2);
  if (filter.indexOf('m:') === 0) {
    const p = filter.slice(2).split('-');
    return MOIS_FR[+p[1] - 1] + ' ' + p[0];
  }
  if (filter === 'custom') {
    if (!periodStart || !periodEnd) return 'plage personnalisée';
    let a = periodStart,
      b = periodEnd;
    if (a > b) {
      const t = a;
      a = b;
      b = t;
    }
    return 'du ' + ddmmyyyy(a) + ' au ' + ddmmyyyy(b);
  }
  return filter;
}

export const EMPTY_FILTERS = { site: '', agent: '', tech: '', requete: '', action: '', niveau: '' };
