// Formatting + normalization helpers (ported from ClienTara.html).

export const nf = new Intl.NumberFormat('fr-FR');

export const num = (v) => {
  const n = Number(v);
  return isNaN(n) ? 0 : n;
};

export function money(n) {
  return nf.format(Math.round(num(n))) + ' Ar';
}

export function moneyShort(n) {
  n = num(n);
  if (n >= 1e9) return (n / 1e9).toFixed(1).replace('.0', '') + ' Md';
  if (n >= 1e6) return (n / 1e6).toFixed(1).replace('.0', '') + ' M';
  if (n >= 1e3) return Math.round(n / 1e3) + ' k';
  return nf.format(n);
}

export function fmtDate(s) {
  if (!s) return '—';
  const d = new Date(s);
  if (isNaN(d)) return String(s);
  return d.toLocaleDateString('fr-FR', { day: '2-digit', month: 'short', year: 'numeric' });
}

export function monthKey(s) {
  if (!s) return null;
  const d = new Date(s);
  if (isNaN(d)) return null;
  return d.getFullYear() + '-' + String(d.getMonth() + 1).padStart(2, '0');
}

export function fmtMonth(k) {
  if (!k) return '';
  const [y, m] = k.split('-');
  return new Date(y, m - 1, 1).toLocaleDateString('fr-FR', { month: 'short', year: '2-digit' });
}

export function initials(name) {
  const p = String(name || '?').trim().split(/\s+/);
  return ((p[0] || '?')[0] + ((p[1] || '')[0] || '')).toUpperCase();
}

export const norm = (s) =>
  String(s == null ? '' : s)
    .toLowerCase()
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '');

export const pad2 = (n) => String(n).padStart(2, '0');

export function fmtAudit(ts) {
  const d = new Date(ts);
  if (isNaN(d)) return String(ts || '—');
  return (
    pad2(d.getDate()) +
    '/' +
    pad2(d.getMonth() + 1) +
    '/' +
    d.getFullYear() +
    ' à ' +
    pad2(d.getHours()) +
    'h' +
    pad2(d.getMinutes())
  );
}

export const MOIS_FR = [
  'janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin',
  'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.',
];
