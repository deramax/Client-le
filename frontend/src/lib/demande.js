// Business semantics for "demande" objects — ported verbatim from ClienTara.html
// (lines ~803-905). The French keys are authoritative.
import { num, monthKey } from './format.js';

export const isResilie = (d) => d.Action === 'Résiliation';
export const isRetenu = (d) => !isResilie(d);
export const isBascule = (d) => d.Action === 'Basculement';
export const isPending = (d) => (d['Niveau décision'] || '') === 'En Attente';
export const isClosed = (d) => (d['Niveau décision'] || '') === 'Cloturé';
export const montAncien = (d) => num(d.Ancien_Mensualité_TTC);
export const montNouveau = (d) => num(d.Nouveau_Mensualité_TTC);
export const montActuel = (d) =>
  isResilie(d) ? 0 : montNouveau(d) > 0 ? montNouveau(d) : montAncien(d);

// Population à risque = demandes de résiliation.
export const isDemandeResil = (d) => (d.Requête_client || '') === 'Résiliation';

export function retentionStats(list) {
  const dem = (list || []).filter(isDemandeResil);
  let retenus = 0,
    perdus = 0,
    caPerdu = 0,
    caSauve = 0;
  dem.forEach((d) => {
    if (isResilie(d)) {
      perdus++;
      caPerdu += montAncien(d);
    } else {
      retenus++;
      caSauve += montActuel(d);
    }
  });
  return {
    dem: dem.length,
    retenus,
    perdus,
    taux: dem.length ? Math.round((retenus / dem.length) * 100) : 0,
    caPerdu,
    caSauve,
  };
}

export function kpis(list) {
  list = list || [];
  let pending = 0,
    closed = 0,
    basc = 0,
    caActuel = 0;
  list.forEach((d) => {
    if (isPending(d)) pending++;
    else closed++;
    if (isRetenu(d)) caActuel += montActuel(d);
    if (isBascule(d)) basc++;
  });
  const rf = retentionStats(list);
  return {
    total: list.length,
    pending,
    closed,
    basc,
    caActuel,
    res: rf.perdus,
    ret: rf.retenus,
    taux: rf.taux,
    dem: rf.dem,
    retenus: rf.retenus,
    perdus: rf.perdus,
    caRes: rf.caPerdu,
    caRet: rf.caSauve,
    caPerdu: rf.caPerdu,
    caSauve: rf.caSauve,
  };
}

export function resilByTech(list) {
  const map = {};
  (list || []).filter(isDemandeResil).forEach((d) => {
    const t = d.Technologie || '—';
    if (!map[t]) map[t] = { dem: 0, retenus: 0, perdus: 0 };
    map[t].dem++;
    if (isResilie(d)) map[t].perdus++;
    else map[t].retenus++;
  });
  return Object.entries(map)
    .map(([t, s]) => ({
      tech: t,
      dem: s.dem,
      retenus: s.retenus,
      perdus: s.perdus,
      taux: s.dem ? Math.round((s.retenus / s.dem) * 100) : 0,
    }))
    .sort((a, b) => b.dem - a.dem);
}

export function allMonths(list) {
  const set = new Set();
  (list || []).forEach((d) => {
    const k = monthKey(d['Date de réception']);
    if (k) set.add(k);
  });
  return [...set].sort();
}

export function groupCount(list, key) {
  const m = {};
  (list || []).forEach((d) => {
    const v = d[key] || '—';
    m[v] = (m[v] || 0) + 1;
  });
  return Object.entries(m).sort((a, b) => b[1] - a[1]);
}

export function monthlySeries(list) {
  const months = allMonths(list);
  const recu = {},
    res = {},
    ret = {},
    basc = {};
  months.forEach((k) => {
    recu[k] = 0;
    res[k] = 0;
    ret[k] = 0;
    basc[k] = 0;
  });
  (list || []).forEach((d) => {
    const k = monthKey(d['Date de réception']);
    if (!k || !(k in recu)) return;
    recu[k]++;
    if (isDemandeResil(d)) {
      if (isResilie(d)) res[k] += montAncien(d);
      else ret[k] += montActuel(d);
    }
    if (isBascule(d)) basc[k]++;
  });
  return { months, recu, res, ret, basc };
}

export function agentPerf(list) {
  const by = {};
  (list || []).forEach((d) => {
    const a = d.Agent_fidélisation || '—';
    by[a] = by[a] || { agent: a, total: 0, dem: 0, retenus: 0, perdus: 0, caSauve: 0, caPerdu: 0 };
    by[a].total++;
    if (isDemandeResil(d)) {
      by[a].dem++;
      if (isResilie(d)) {
        by[a].perdus++;
        by[a].caPerdu += montAncien(d);
      } else {
        by[a].retenus++;
        by[a].caSauve += montActuel(d);
      }
    }
  });
  return Object.values(by)
    .map((r) => ((r.taux = r.dem ? Math.round((r.retenus / r.dem) * 100) : 0), r))
    .sort((x, y) => y.dem - x.dem);
}

export function resilProductMotif(list) {
  const dem = (list || []).filter((d) => isDemandeResil(d) && isResilie(d));
  const techs = {},
    motifTotals = {};
  dem.forEach((d) => {
    const t = d.Technologie || '—',
      m = d.Motif || '—';
    techs[t] = techs[t] || {};
    techs[t][m] = (techs[t][m] || 0) + 1;
    motifTotals[m] = (motifTotals[m] || 0) + 1;
  });
  const motifs = Object.keys(motifTotals).sort((a, b) => motifTotals[b] - motifTotals[a]);
  const techList = Object.keys(techs).sort(
    (a, b) =>
      Object.values(techs[b]).reduce((x, y) => x + y, 0) -
      Object.values(techs[a]).reduce((x, y) => x + y, 0)
  );
  return { techs, motifs, techList, motifTotals, total: dem.length };
}

export function splitResilRet(list) {
  const dem = (list || []).filter(isDemandeResil);
  return { resil: dem.filter(isResilie), ret: dem.filter((d) => !isResilie(d)) };
}

// Prefill mapping from a 4D "dossier" (ported from dossier4DToPrefill).
export function dossier4DToPrefill(dos) {
  const c = dos.client || {},
    p0 = (dos.produits || [])[0] || {},
    p1 = (dos.produits || [])[1] || {},
    k0 = (dos.contrats || [])[0] || {},
    k1 = (dos.contrats || [])[1] || {};
  const pre = { Refnum: c.refnum || '', Nom_Client: c.nom || '' };
  if (p0.technologie) pre.Technologie = p0.technologie;
  if (p0.produit) pre.Ancien_produit = p0.produit;
  if (p0.id_produit) pre['Réf_produit'] = p0.id_produit;
  if (k0.date_debut) pre.Date_Contrat = k0.date_debut;
  if (p1.produit) pre.Nouveau_produit = p1.produit;
  if (k1.date_debut) pre.Date_Nv_Contrat = k1.date_debut;
  return pre;
}

// CSV export (client-side) — same columns as legacy.
export function demandesToCSV(list) {
  const cols = [
    'id', 'ID_FID', 'Date de réception', 'Site', 'Agent_fidélisation', 'Refnum',
    'Nom_Client', 'Technologie', 'Ancien_produit', 'Ancien_Mensualité_TTC',
    'Requête_client', 'Motif', 'Action', 'Niveau décision', 'Date prévue_Execution',
    'Date_Cloture', 'Agent_Confirmation', 'Nouveau_produit', 'Nouveau_Mensualité_TTC',
  ];
  const esc2 = (v) => {
    v = v == null ? '' : String(v).replace(/"/g, '""');
    return /[;"\n]/.test(v) ? '"' + v + '"' : v;
  };
  const rows = [cols.join(';')].concat(
    (list || []).map((d) => cols.map((c) => esc2(d[c])).join(';'))
  );
  return '﻿' + rows.join('\n');
}

export function downloadFile(content, filename, type) {
  const blob = new Blob([content], { type: type || 'text/plain;charset=utf-8' });
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = filename;
  a.click();
  setTimeout(() => URL.revokeObjectURL(a.href), 1000);
}
