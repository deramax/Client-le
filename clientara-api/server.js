/* =====================================================================
 *  ClienTara  <->  source de donnees   :  PORTAIL API
 *  ---------------------------------------------------------------
 *  Passerelle entre l'application ClienTara (page HTML) et la source
 *  des donnees clients. DEUX MODES, choisis par DATA_SOURCE (.env) :
 *
 *    DATA_SOURCE=demo        -> extrait du FICHIER EXCEL source (clients-source.xlsx)
 *    DATA_SOURCE=production   -> extrait du SERVEUR 4D (API REST)
 *
 *  Dans les deux cas, le portail renvoie le MEME format a ClienTara :
 *    { client, produits[], contrats[] }
 *
 *  Demarrage :  npm install   puis   npm start
 *  Necessite Node.js 18+ (pour "fetch" integre).
 * ===================================================================== */

const express = require('express');
const fs = require('fs');
const path = require('path');

/* ---------- 1) Mini-lecteur de fichier .env (pas de dependance) ---------- */
(function loadEnv() {
  try {
    const p = path.join(__dirname, '.env');
    if (!fs.existsSync(p)) return;
    fs.readFileSync(p, 'utf8').split(/\r?\n/).forEach(line => {
      if (line.trim().startsWith('#')) return;
      const m = /^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/.exec(line);
      if (m) {
        const key = m[1]; let val = m[2];
        if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'"))) val = val.slice(1, -1);
        if (process.env[key] === undefined) process.env[key] = val;
      }
    });
  } catch (e) { /* ignore */ }
})();

function normMode(v) {
  v = (v || '').toLowerCase().trim();
  if (['production', 'prod', 'fourd', '4d'].includes(v)) return 'production';
  return 'demo'; // demo / mock / excel -> demo
}

const CFG = {
  PORT: parseInt(process.env.PORT || '4000', 10),
  SOURCE: normMode(process.env.DATA_SOURCE || 'demo'),
  EXCEL_FILE: process.env.EXCEL_FILE || 'clients-source.xlsx',
  FOURD_URL: (process.env.FOURD_URL || '').replace(/\/+$/, ''),
  FOURD_USER: process.env.FOURD_USER || '',
  FOURD_PASSWORD: process.env.FOURD_PASSWORD || '',
  FOURD_TIMEOUT: parseInt(process.env.FOURD_TIMEOUT || '10000', 10),
  API_TOKEN: process.env.API_TOKEN || ''
};

const MAP = JSON.parse(fs.readFileSync(path.join(__dirname, 'mapping.json'), 'utf8'));

const app = express();
app.use(express.json());

/* ---------- CORS : autoriser l'application a appeler ce portail ---------- */
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*'); // production : mettre l'URL exacte de ClienTara
  res.header('Access-Control-Allow-Headers', 'Content-Type, x-api-token');
  res.header('Access-Control-Allow-Methods', 'GET, OPTIONS');
  if (req.method === 'OPTIONS') return res.sendStatus(204);
  next();
});

/* ---------- Jeton simple (optionnel) ---------- */
app.use('/api', (req, res, next) => {
  if (CFG.API_TOKEN && req.get('x-api-token') !== CFG.API_TOKEN) {
    return res.status(401).json({ error: 'Jeton API invalide ou manquant (en-tete x-api-token).' });
  }
  next();
});

/* =====================================================================
 *  MODE DEMO : extraction du fichier Excel source
 *  Feuille "BD clients" -> liste des clients (Refnum + Nom)
 *  Feuille "Journal"    -> produits et contrats de chaque client
 * ===================================================================== */
let DEMO = null;       // cache { byRef, list, count }
let DEMO_ERR = null;   // message d'erreur eventuel

function buildDemo() {
  const XLSX = require('xlsx');
  const file = path.join(__dirname, CFG.EXCEL_FILE);
  if (!fs.existsSync(file)) throw new Error('Fichier Excel introuvable : ' + CFG.EXCEL_FILE);
  const wb = XLSX.readFile(file);
  const em = MAP.excel;
  const jSheet = wb.Sheets[em.sheets.journal];
  const cSheet = wb.Sheets[em.sheets.clients];
  const journal = jSheet ? XLSX.utils.sheet_to_json(jSheet, { defval: null, raw: true }) : [];
  const clientsRows = cSheet ? XLSX.utils.sheet_to_json(cSheet, { defval: null, raw: true }) : [];

  const clean = v => (v == null ? '' : String(v)).replace(/\s+/g, ' ').trim();
  const fmtDate = v => {
    if (v == null || v === '') return '';
    if (typeof v === 'number') { const ms = Math.round((v - 25569) * 86400000); const d = new Date(ms); const p = n => String(n).padStart(2, '0'); return d.getUTCFullYear() + '-' + p(d.getUTCMonth() + 1) + '-' + p(d.getUTCDate()); }
    if (v instanceof Date && !isNaN(v)) { const p = n => String(n).padStart(2, '0'); return v.getUTCFullYear() + '-' + p(v.getUTCMonth() + 1) + '-' + p(v.getUTCDate()); }
    return clean(v);
  };

  const C = em.clients, J = em.journal;
  const byRef = {};
  const ensure = (ref, nom) => { if (!byRef[ref]) byRef[ref] = { client: { refnum: ref, nom: clean(nom), mail: '', telephone: '', adresse: '' }, produits: [], contrats: [] }; return byRef[ref]; };

  // 1) clients depuis la feuille "BD clients"
  clientsRows.forEach(r => { const ref = clean(r[C.refnum]); if (ref) ensure(ref, r[C.nom]); });

  // 2) journal -> compléter + produits + contrats
  const seenP = {}, seenK = {};
  journal.forEach(r => {
    const ref = clean(r[J.refnum]); if (!ref) return;
    const rec = ensure(ref, r[J.nom]);
    if (!rec.client.nom) rec.client.nom = clean(r[J.nom]);
    const tech = clean(r[J.technologie]);

    const ap = clean(r[J.ancien_produit]);
    if (ap) { const k = ref + '|' + clean(r[J.id_produit]) + '|' + ap; if (!seenP[k]) { seenP[k] = 1; rec.produits.push({ id_produit: clean(r[J.id_produit]), intitule: ap, technologie: tech, produit: ap }); } }
    const np = clean(r[J.nouveau_produit]);
    if (np) { const k = ref + '|' + clean(r[J.ref_nouv_produit]) + '|' + np; if (!seenP[k]) { seenP[k] = 1; rec.produits.push({ id_produit: clean(r[J.ref_nouv_produit]), intitule: np, technologie: tech, produit: np }); } }

    const d1 = fmtDate(r[J.date_contrat]);
    if (d1) { const k = ref + '|' + d1; if (!seenK[k]) { seenK[k] = 1; rec.contrats.push({ id_contrat: 'CT-' + ref + '-' + d1.slice(0, 4), type_contrat: '', date_debut: d1, date_fin: '', duree: '', facturation: '' }); } }
    const d2 = fmtDate(r[J.date_nv_contrat]);
    if (d2) { const k = ref + '|' + d2; if (!seenK[k]) { seenK[k] = 1; rec.contrats.push({ id_contrat: 'CT-' + ref + '-' + d2.slice(0, 4), type_contrat: '', date_debut: d2, date_fin: '', duree: '', facturation: '' }); } }
  });

  const list = Object.values(byRef).map(x => x.client);
  return { byRef, list, count: list.length };
}

function getDemo() {
  if (DEMO) return DEMO;
  try { DEMO = buildDemo(); DEMO_ERR = null; } catch (e) { DEMO_ERR = String(e.message || e); DEMO = { byRef: {}, list: [], count: 0 }; }
  return DEMO;
}

function demoSearch(q) {
  q = (q || '').toLowerCase().trim();
  const d = getDemo();
  const out = [];
  for (const c of d.list) {
    if (!q || String(c.refnum).toLowerCase().includes(q) || (c.nom || '').toLowerCase().includes(q)) out.push(c);
    if (out.length >= 25) break;
  }
  return out;
}
function demoDossier(refnum) {
  const d = getDemo();
  const rec = d.byRef[String(refnum).trim()];
  return rec ? { client: rec.client, produits: rec.produits, contrats: rec.contrats } : null;
}

/* =====================================================================
 *  MODE PRODUCTION : serveur 4D via REST
 *  Docs : https://developer.4d.com/docs/REST/
 * ===================================================================== */
let FOURD_COOKIE = '';
function withTimeout(ms) { const c = new AbortController(); const t = setTimeout(() => c.abort(), ms); return { signal: c.signal, done: () => clearTimeout(t) }; }

async function fourdLogin() {
  if (!CFG.FOURD_USER) return;
  const t = withTimeout(CFG.FOURD_TIMEOUT);
  try {
    const r = await fetch(`${CFG.FOURD_URL}/rest/$directory/login`, { method: 'POST', headers: { 'username': CFG.FOURD_USER, 'password': CFG.FOURD_PASSWORD }, signal: t.signal });
    const setCookie = r.headers.get('set-cookie');
    if (setCookie) FOURD_COOKIE = setCookie.split(';')[0];
    if (!r.ok) throw new Error('Echec de connexion 4D (HTTP ' + r.status + ')');
  } finally { t.done(); }
}
async function fourdGet(restPath, retry = true) {
  const t = withTimeout(CFG.FOURD_TIMEOUT);
  try {
    const r = await fetch(`${CFG.FOURD_URL}/rest/${restPath}`, { headers: FOURD_COOKIE ? { 'Cookie': FOURD_COOKIE } : {}, signal: t.signal });
    if ((r.status === 401 || r.status === 403) && retry) { await fourdLogin(); return fourdGet(restPath, false); }
    if (!r.ok) throw new Error('Reponse 4D HTTP ' + r.status);
    return await r.json();
  } finally { t.done(); }
}
function esc4d(v) { return String(v).replace(/'/g, "\\'"); }
function mapEntity(entity, fieldMap) { const out = {}; for (const c of Object.keys(fieldMap)) { if (c.startsWith('_')) continue; out[c] = entity[fieldMap[c]] != null ? entity[fieldMap[c]] : ''; } return out; }
function attrList(fieldMap) { const s = new Set(); for (const c of Object.keys(fieldMap)) { if (c === '_search') continue; if (c.startsWith('_')) { if (typeof fieldMap[c] === 'string') s.add(fieldMap[c]); continue; } s.add(fieldMap[c]); } return [...s].join(','); }

async function fourdSearch(q) {
  const dc = MAP.dataClasses.client, attrs = attrList(MAP.client);
  let url;
  if (q && q.trim()) {
    const parts = (MAP.client._search || [MAP.client.refnum]).map(a => `${a}='@${esc4d(q.trim())}@'`);
    url = `${dc}/?$filter=${encodeURIComponent('(' + parts.join(') OR (') + ')')}&$attributes=${attrs}&$top=25`;
  } else { url = `${dc}/?$attributes=${attrs}&$top=25`; }
  const data = await fourdGet(url);
  return (data.__ENTITIES || []).map(e => mapEntity(e, MAP.client));
}
async function fourdLinked(dataClass, fieldMap, refnum) {
  const fk = fieldMap._client_fk; if (!fk) return [];
  const attrs = attrList(fieldMap);
  try { const data = await fourdGet(`${dataClass}/?$filter=${encodeURIComponent(fk + "='" + esc4d(refnum) + "'")}&$attributes=${attrs}&$top=100`); return (data.__ENTITIES || []).map(e => mapEntity(e, fieldMap)); }
  catch (e) { return []; }
}
async function fourdDossier(refnum) {
  const dcC = MAP.dataClasses.client, cAttrs = attrList(MAP.client);
  const cData = await fourdGet(`${dcC}/?$filter=${encodeURIComponent(MAP.client.refnum + "='" + esc4d(refnum) + "'")}&$attributes=${cAttrs}`);
  const cEnt = (cData.__ENTITIES || [])[0];
  if (!cEnt) return null;
  const client = mapEntity(cEnt, MAP.client);
  const produits = await fourdLinked(MAP.dataClasses.produit, MAP.produit, refnum);
  const contrats = await fourdLinked(MAP.dataClasses.contrat, MAP.contrat, refnum);
  return { client, produits, contrats };
}

/* =====================================================================
 *  ROUTES
 * ===================================================================== */
app.get('/health', (req, res) => {
  const out = { ok: true, mode: CFG.SOURCE, time: new Date().toISOString() };
  if (CFG.SOURCE === 'demo') { const d = getDemo(); out.excelFile = CFG.EXCEL_FILE; out.clients = d.count; if (DEMO_ERR) { out.ok = false; out.error = DEMO_ERR; } }
  else { out.fourdConfigured = !!CFG.FOURD_URL; out.fourdUrl = CFG.FOURD_URL || null; }
  res.json(out);
});

app.get('/api/config', (req, res) => {
  res.json({ mode: CFG.SOURCE, excelFile: CFG.SOURCE === 'demo' ? CFG.EXCEL_FILE : null, fourdUrl: CFG.SOURCE === 'production' ? (CFG.FOURD_URL || null) : null, mapping: MAP });
});

app.get('/api/clients/search', async (req, res) => {
  try {
    const q = req.query.q || '';
    const results = CFG.SOURCE === 'production' ? await fourdSearch(q) : demoSearch(q);
    res.json({ mode: CFG.SOURCE, count: results.length, results });
  } catch (e) { res.status(502).json({ error: 'Recherche impossible', detail: String(e.message || e), mode: CFG.SOURCE }); }
});

app.get('/api/clients/:refnum', async (req, res) => {
  try {
    const refnum = req.params.refnum;
    const dossier = CFG.SOURCE === 'production' ? await fourdDossier(refnum) : demoDossier(refnum);
    if (!dossier) return res.status(404).json({ found: false, error: 'Client introuvable', refnum });
    res.json({ found: true, mode: CFG.SOURCE, ...dossier });
  } catch (e) { res.status(502).json({ error: 'Lecture impossible', detail: String(e.message || e), mode: CFG.SOURCE }); }
});

app.get('/', (req, res) => res.type('html').send(PORTAL_HTML));

app.listen(CFG.PORT, () => {
  console.log('-----------------------------------------------------------');
  console.log(' Portail API ClienTara demarre');
  console.log(' MODE : ' + CFG.SOURCE.toUpperCase() + (CFG.SOURCE === 'demo' ? '  (extraction du fichier Excel)' : '  (extraction du serveur 4D)'));
  if (CFG.SOURCE === 'demo') { const d = getDemo(); if (DEMO_ERR) console.log(' ATTENTION : ' + DEMO_ERR); else console.log(' Fichier  : ' + CFG.EXCEL_FILE + '  (' + d.count + ' clients charges)'); }
  else if (!CFG.FOURD_URL) console.log(' ATTENTION : mode production mais FOURD_URL est vide.');
  console.log(' Page     : http://localhost:' + CFG.PORT + '/');
  console.log(' Recherche: http://localhost:' + CFG.PORT + '/api/clients/search?q=145238');
  console.log('-----------------------------------------------------------');
});

/* ---------- Page de test (http://localhost:PORT) ---------- */
const PORTAL_HTML = `<!doctype html><html lang="fr"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Portail API ClienTara</title>
<style>
 :root{--p:#0e7490;--b:#e2e8f0;--t:#0f172a;--m:#64748b}
 *{box-sizing:border-box} body{font-family:system-ui,Segoe UI,Roboto,sans-serif;margin:0;background:#f8fafc;color:var(--t)}
 header{background:var(--p);color:#fff;padding:18px 24px} header h1{margin:0;font-size:18px} header p{margin:4px 0 0;opacity:.9;font-size:13px}
 main{max-width:880px;margin:24px auto;padding:0 16px}
 .card{background:#fff;border:1px solid var(--b);border-radius:12px;padding:18px;margin-bottom:18px}
 .row{display:flex;gap:8px;flex-wrap:wrap} input{flex:1;min-width:220px;padding:10px 12px;border:1px solid var(--b);border-radius:9px;font-size:14px}
 button{background:var(--p);color:#fff;border:0;border-radius:9px;padding:10px 16px;font-size:14px;cursor:pointer}
 .res{margin-top:14px} .item{border:1px solid var(--b);border-radius:9px;padding:10px 12px;margin-bottom:8px;cursor:pointer}
 .item:hover{border-color:var(--p);background:#f0fdfa} .item b{font-size:14px} .item span{color:var(--m);font-size:12px}
 pre{background:#0f172a;color:#e2e8f0;border-radius:9px;padding:14px;overflow:auto;font-size:12px;line-height:1.5}
 .lbl{font-size:11px;text-transform:uppercase;letter-spacing:.05em;color:var(--m);margin:14px 0 6px}
 .pill{display:inline-block;background:#f1f5f9;border:1px solid var(--b);border-radius:999px;padding:2px 10px;font-size:12px;margin:2px}
 .tag{font-size:11px;background:#ecfeff;color:#0e7490;border:1px solid #a5f3fc;border-radius:6px;padding:2px 9px;font-weight:600}
</style></head><body>
<header><h1>Portail API &mdash; ClienTara</h1><p>Recherche un client par <b>Refnum</b> ou par <b>nom</b>, puis genere son dossier (client, produits, contrats).</p></header>
<main>
 <div class="card">
   <div class="row"><input id="q" placeholder="Ex : 145238  ou  RAZAFI" /><button onclick="rechercher()">Rechercher</button></div>
   <div class="res" id="results"></div>
 </div>
 <div class="card" id="dossierCard" style="display:none">
   <div id="dossier"></div>
   <div class="lbl">Reponse JSON (ce que recoit ClienTara)</div><pre id="json"></pre>
 </div>
 <div class="card"><span class="tag" id="modeTag">...</span></div>
</main>
<script>
 const API=location.origin;
 fetch(API+'/health').then(r=>r.json()).then(d=>{document.getElementById('modeTag').textContent='MODE : '+(d.mode||'?').toUpperCase()+(d.mode==='demo'?(' \\u2022 '+(d.clients||0)+' clients (Excel)'):' \\u2022 serveur 4D');}).catch(()=>{});
 async function rechercher(){
   const q=document.getElementById('q').value.trim(); const box=document.getElementById('results'); box.innerHTML='Recherche...';
   try{ const d=await (await fetch(API+'/api/clients/search?q='+encodeURIComponent(q))).json();
     if(!d.results||!d.results.length){box.innerHTML='<span style="color:#64748b">Aucun client trouve.</span>';return;}
     box.innerHTML=d.results.map(c=>'<div class="item" onclick="ouvrir(\\''+String(c.refnum).replace(/'/g,"")+'\\')"><b>'+(c.nom||'(sans nom)')+'</b> &nbsp;<span>Refnum '+c.refnum+'</span></div>').join('');
   }catch(e){box.innerHTML='<span style="color:#dc2626">Erreur : '+e+'</span>';}
 }
 async function ouvrir(refnum){
   const d=await (await fetch(API+'/api/clients/'+encodeURIComponent(refnum))).json();
   document.getElementById('dossierCard').style.display='block'; document.getElementById('json').textContent=JSON.stringify(d,null,2);
   if(!d.found){document.getElementById('dossier').innerHTML='<b>Client introuvable.</b>';return;}
   const c=d.client;
   const prod=(d.produits||[]).map(p=>'<span class="pill">'+(p.intitule||p.produit||'?')+' &middot; '+(p.technologie||'')+'</span>').join(' ')||'<span style="color:#64748b">aucun</span>';
   const ctr=(d.contrats||[]).map(k=>'<span class="pill">'+(k.date_debut||'?')+(k.date_fin?(' &rarr; '+k.date_fin):'')+(k.type_contrat?(' &middot; '+k.type_contrat):'')+'</span>').join(' ')||'<span style="color:#64748b">aucun</span>';
   document.getElementById('dossier').innerHTML='<div class="lbl">Client</div><b>'+(c.nom||'')+'</b> (Refnum '+c.refnum+')<br><span style="color:#64748b;font-size:13px">'+(c.mail||'&mdash;')+' &middot; '+(c.telephone||'&mdash;')+' &middot; '+(c.adresse||'&mdash;')+'</span><div class="lbl">Produits</div>'+prod+'<div class="lbl">Contrats</div>'+ctr;
 }
 document.getElementById('q').addEventListener('keydown',e=>{if(e.key==='Enter')rechercher();});
</script></body></html>`;
