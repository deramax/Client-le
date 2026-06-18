/* =====================================================================
 *  SNIPPET d'integration : ClienTara  ->  Portail API  ->  4D
 *  ---------------------------------------------------------------
 *  A COLLER dans ClienTara.html, a l'interieur de la grande balise
 *  <script> ... </script> (par exemple juste avant "function init()").
 *
 *  Ce que ca ajoute :
 *   - chercherClient4D(q)     : recherche par Refnum ou nom (renvoie une liste)
 *   - chargerDossier4D(refnum): recupere client + produits + contrats
 *   - prefillFormulaire4D(d)  : pre-remplit le formulaire de demande ouvert
 *   - ouvrirRecherche4D()     : petite fenetre de recherche (modale ClienTara)
 *
 *  IMPORTANT : le portail doit tourner (npm start) et etre joignable.
 *  Adapte l'URL ci-dessous si besoin.
 * ===================================================================== */

const CLIENTARA_API = 'http://localhost:4000';   // URL du portail API
const CLIENTARA_API_TOKEN = '';                  // si tu as mis un API_TOKEN cote portail

function _api4dHeaders() {
  return CLIENTARA_API_TOKEN ? { 'x-api-token': CLIENTARA_API_TOKEN } : {};
}

// 1) Recherche : renvoie un tableau [{refnum, nom, mail, telephone, adresse}]
async function chercherClient4D(q) {
  const r = await fetch(CLIENTARA_API + '/api/clients/search?q=' + encodeURIComponent(q || ''), { headers: _api4dHeaders() });
  if (!r.ok) throw new Error('Recherche indisponible (HTTP ' + r.status + ')');
  const d = await r.json();
  return d.results || [];
}

// 2) Dossier complet : { client, produits[], contrats[] }
async function chargerDossier4D(refnum) {
  const r = await fetch(CLIENTARA_API + '/api/clients/' + encodeURIComponent(refnum), { headers: _api4dHeaders() });
  if (r.status === 404) return null;
  if (!r.ok) throw new Error('Lecture indisponible (HTTP ' + r.status + ')');
  return await r.json();
}

// 3) Pre-remplissage du formulaire de demande ouvert (openRequestForm)
//    -> remplit Refnum, Nom du client, et le 1er produit (ancien produit / techno / mensualite).
function prefillFormulaire4D(dossier) {
  const f = document.getElementById('reqForm');
  if (!f || !dossier || !dossier.client) { toast && toast('Ouvre d\'abord une nouvelle requete.'); return; }
  const set = (name, val) => { const el = f.elements[name]; if (el && val != null && val !== '') el.value = val; };
  const c = dossier.client;
  set('Refnum', c.refnum);
  set('Nom_Client', c.nom);
  const p = (dossier.produits || [])[0];
  if (p) {
    set('Ancien_produit', p.produit);     // doit exister dans le referentiel Produits, sinon laisse vide
    set('Technologie', p.technologie);
    set('Réf_produit', p.id_produit);
  }
  // Mise a jour du bandeau Requete->Action si present
  if (typeof updateReqTransform === 'function') updateReqTransform();
  toast && toast('Informations client importees depuis 4D');
}

// 4) Petite fenetre de recherche, branchee sur le systeme de modale de ClienTara
function ouvrirRecherche4D() {
  if (typeof openModal !== 'function') { alert('openModal introuvable.'); return; }
  const body = `
    <div class="row" style="display:flex;gap:8px;flex-wrap:wrap">
      <input id="s4d_q" placeholder="Refnum ou nom du client" style="flex:1;min-width:200px;padding:10px 12px;border:1px solid var(--border);border-radius:9px">
      <button class="btn btn-primary" onclick="run4DSearch()">Rechercher</button>
    </div>
    <div id="s4d_res" style="margin-top:12px"></div>`;
  openModal('Rechercher un client (serveur 4D)', 'Genere automatiquement le dossier client', body, '',
    '<button class="btn btn-ghost" onclick="closeModal()">Fermer</button>');
  setTimeout(() => { const e = document.getElementById('s4d_q'); if (e) { e.focus(); e.addEventListener('keydown', ev => { if (ev.key === 'Enter') run4DSearch(); }); } }, 30);
}

async function run4DSearch() {
  const q = (document.getElementById('s4d_q') || {}).value || '';
  const box = document.getElementById('s4d_res'); if (box) box.innerHTML = 'Recherche...';
  try {
    const list = await chercherClient4D(q);
    if (!list.length) { box.innerHTML = '<div class="empty">Aucun client trouve.</div>'; return; }
    box.innerHTML = list.map(c =>
      `<div class="item" style="border:1px solid var(--border);border-radius:9px;padding:10px;margin-bottom:8px;cursor:pointer"
            onclick="importer4D('${String(c.refnum).replace(/'/g, '')}')">
         <b>${esc ? esc(c.nom || '') : (c.nom || '')}</b> &middot; <span style="color:var(--text-3)">Refnum ${c.refnum}</span>
       </div>`).join('');
  } catch (e) { if (box) box.innerHTML = '<div class="empty" style="color:#dc2626">' + e.message + '</div>'; }
}

async function importer4D(refnum) {
  try {
    const d = await chargerDossier4D(refnum);
    if (!d || !d.found) { toast && toast('Client introuvable'); return; }
    closeModal && closeModal();
    if (typeof openNewRequest === 'function') openNewRequest();   // ouvre une nouvelle requete
    setTimeout(() => prefillFormulaire4D(d), 60);                  // puis pre-remplit
  } catch (e) { toast && toast(e.message); }
}

/* ---------------------------------------------------------------------
 *  Pour afficher un bouton "Rechercher dans 4D" :
 *  ajoute par exemple, dans la barre de l'onglet Demandes, un bouton :
 *      <button class="btn btn-primary" onclick="ouvrirRecherche4D()">+ Importer depuis 4D</button>
 *  (ou appelle ouvrirRecherche4D() depuis n'importe quel bouton existant)
 * ------------------------------------------------------------------- */
