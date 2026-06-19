// Create / edit demande form (modal). Sections: Réception, Client, Contrat
// actuel, Requête, Traitement & décision, Nouveau contrat.
import { useMemo, useState } from 'react';
import Modal from '../../components/Modal.jsx';
import { useData } from '../../data/DataContext.jsx';
import { useToast } from '../../components/Toast.jsx';
import api from '../../api/client.js';
import { num, nf } from '../../lib/format.js';
import { PRIORITES } from '../../lib/constants.js';
import {
  IconDoc, IconUser, IconCash, IconHist, IconShield, IconTrendUp,
} from '../../components/Icons.jsx';

const REQUIRED = ['Nom_Client', 'Refnum', 'Site', 'Requête_client', 'Action'];

function Section({ icon, children }) {
  return (
    <div className="form-section">
      {icon} {children}
    </div>
  );
}

function FieldText({ label, name, value, onChange, type = 'text', placeholder, req, full, textarea }) {
  return (
    <div className={`field${full ? ' full' : ''}`}>
      <label>
        {label}
        {req ? <span className="req"> *</span> : null}
      </label>
      {textarea ? (
        <textarea name={name} value={value} placeholder={placeholder} onChange={onChange} />
      ) : (
        <input type={type} name={name} value={value} placeholder={placeholder} onChange={onChange} />
      )}
    </div>
  );
}

function FieldSelect({ label, name, value, onChange, options, req, placeholder = '— Sélectionner —' }) {
  return (
    <div className="field">
      <label>
        {label}
        {req ? <span className="req"> *</span> : null}
      </label>
      <select name={name} value={value} onChange={onChange}>
        <option value="">{placeholder}</option>
        {options.map((o) => (
          <option key={o} value={o}>
            {o}
          </option>
        ))}
      </select>
    </div>
  );
}

// Transformation banner: Requête client -> Action décidée (+ financial impact).
function Transform({ req, act, oldM, newM }) {
  const issue = !act ? 'pending' : act === 'Résiliation' ? 'lost' : 'kept';
  let badge;
  if (issue === 'pending') badge = <span className="badge b-pending">À décider</span>;
  else if (issue === 'lost') badge = <span className="badge b-danger">Client perdu — résiliation confirmée</span>;
  else badge = <span className="badge b-success">Client retenu</span>;

  let moneyEl = null;
  if (issue === 'lost') {
    moneyEl = (
      <span style={{ color: '#dc2626' }}>
        Revenu en jeu perdu : <b>{nf.format(Math.round(oldM || 0))} Ar/mois</b>
      </span>
    );
  } else if (issue === 'kept') {
    if (newM > 0) {
      const dd = (newM || 0) - (oldM || 0);
      const col = dd < 0 ? '#d97706' : dd > 0 ? '#16a34a' : 'var(--text-2)';
      moneyEl = (
        <span style={{ color: 'var(--text-2)' }}>
          Mensualité : <b>{nf.format(Math.round(oldM || 0))}</b> → <b>{nf.format(Math.round(newM))}</b> Ar
          {dd ? (
            <span style={{ color: col }}>
              {' '}
              ({dd > 0 ? '+' : '−'}
              {nf.format(Math.round(Math.abs(dd)))})
            </span>
          ) : null}
        </span>
      );
    } else {
      moneyEl = (
        <span style={{ color: 'var(--text-2)' }}>
          Mensualité conservée : <b>{nf.format(Math.round(oldM || 0))} Ar/mois</b>
        </span>
      );
    }
  }

  return (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        gap: 10,
        padding: '14px 16px',
        borderRadius: 12,
        background: 'var(--primary-soft)',
        border: '1px solid var(--border)',
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', gap: 10, flexWrap: 'wrap' }}>
        <span style={{ fontSize: 10.5, textTransform: 'uppercase', letterSpacing: '.05em', color: 'var(--text-3)' }}>
          Demande client
        </span>
        <span className="badge b-info">{req || '—'}</span>
        <span style={{ color: 'var(--text-3)' }}>→</span>
        <span style={{ fontSize: 10.5, textTransform: 'uppercase', letterSpacing: '.05em', color: 'var(--text-3)' }}>
          Action / décision
        </span>
        {act ? (
          <span className={`badge ${issue === 'lost' ? 'b-danger' : 'b-success'}`}>{act}</span>
        ) : (
          <span className="badge b-neutral">à définir</span>
        )}
      </div>
      <div style={{ display: 'flex', alignItems: 'center', gap: 14, flexWrap: 'wrap', fontSize: 12.5 }}>
        {badge}
        {moneyEl}
      </div>
    </div>
  );
}

const todayStr = () => new Date().toISOString().slice(0, 10);

export default function DemandeForm({ initial, editingId, onClose, onSaved }) {
  const { ref, loadDemandes, loadClients } = useData();
  const toast = useToast();
  const [busy, setBusy] = useState(false);

  const [form, setForm] = useState(() => ({
    'Date de réception': initial['Date de réception'] || todayStr(),
    Site: initial.Site || '',
    Agent_fidélisation: initial.Agent_fidélisation || '',
    Technologie: initial.Technologie || '',
    Refnum: initial.Refnum || '',
    Nom_Client: initial.Nom_Client || '',
    Ancien_produit: initial.Ancien_produit || '',
    Ancien_Mensualité_TTC: initial.Ancien_Mensualité_TTC != null ? num(initial.Ancien_Mensualité_TTC) : '',
    Date_Contrat: initial.Date_Contrat || '',
    Réf_produit: initial['Réf_produit'] || '',
    Requête_client: initial.Requête_client || '',
    Motif: initial.Motif || '',
    'Information libre': initial['Information libre'] || '',
    Action: initial.Action || '',
    Priorité: initial.Priorité || '',
    'Niveau décision': initial['Niveau décision'] || 'En Attente',
    'Date prévue_Execution': initial['Date prévue_Execution'] || '',
    Date_Cloture: initial.Date_Cloture || '',
    Agent_Confirmation: initial.Agent_Confirmation || '',
    Nouveau_produit: initial.Nouveau_produit || '',
    Nouveau_Mensualité_TTC: initial.Nouveau_Mensualité_TTC != null ? num(initial.Nouveau_Mensualité_TTC) : '',
    Nouveau_Nom: initial.Nouveau_Nom || '',
    Date_Nv_Contrat: initial.Date_Nv_Contrat || '',
    __reason: '',
  }));

  const upd = (e) => {
    const { name, value } = e.target;
    setForm((s) => ({ ...s, [name]: value }));
  };

  const priorites = ref.Priorites && ref.Priorites.length ? ref.Priorites : PRIORITES;

  const save = async () => {
    for (const r of REQUIRED) {
      if (!String(form[r] || '').trim()) {
        toast('Veuillez renseigner les champs obligatoires (*)');
        return;
      }
    }
    const payload = { ...form };
    payload.Ancien_Mensualité_TTC = num(payload.Ancien_Mensualité_TTC);
    payload.Nouveau_Mensualité_TTC = num(payload.Nouveau_Mensualité_TTC);
    const reason = (payload.__reason || '').trim();
    delete payload.__reason;
    if (reason) payload.__reason = reason; // backend reads __reason for the audit trail

    setBusy(true);
    try {
      let saved;
      if (editingId) {
        saved = await api.patch(`/demandes/${encodeURIComponent(editingId)}/`, payload);
        toast('Requête mise à jour');
      } else {
        saved = await api.post('/demandes/', payload);
        toast('Nouvelle requête créée' + (saved && saved.id ? ' : ' + saved.id : ''));
      }
      await Promise.all([loadDemandes(), loadClients()]);
      onSaved && onSaved(saved);
      onClose();
    } catch (e) {
      toast(e.message || 'Enregistrement impossible');
      setBusy(false);
    }
  };

  const footer = (
    <>
      <button className="btn btn-ghost" onClick={onClose}>
        Annuler
      </button>
      <button className="btn btn-primary" onClick={save} disabled={busy}>
        {editingId ? 'Enregistrer' : 'Créer la requête'}
      </button>
    </>
  );

  return (
    <Modal
      title={editingId ? 'Modifier la requête' : 'Nouvelle requête'}
      sub={editingId ? editingId : 'Créer une nouvelle requête de fidélisation'}
      size="wide"
      onClose={onClose}
      footer={footer}
    >
      <form onSubmit={(e) => e.preventDefault()}>
        <div className="form-grid">
          <Section icon={<IconDoc size={14} />}>Réception</Section>
          <FieldText label="Date de réception" name="Date de réception" type="date" value={form['Date de réception']} onChange={upd} req />
          <FieldSelect label="Site" name="Site" value={form.Site} onChange={upd} options={ref.Sites} req />
          <FieldSelect label="Agent de fidélisation" name="Agent_fidélisation" value={form.Agent_fidélisation} onChange={upd} options={ref.Agents} />
          <FieldSelect label="Technologie" name="Technologie" value={form.Technologie} onChange={upd} options={ref.Technologies} />

          <Section icon={<IconUser size={14} />}>Client</Section>
          <FieldText label="Référence client (Refnum)" name="Refnum" value={form.Refnum} onChange={upd} placeholder="ex. 145238" req />
          <FieldText label="Nom du client" name="Nom_Client" value={form.Nom_Client} onChange={upd} placeholder="Nom complet" req />

          <Section icon={<IconCash size={14} />}>Contrat actuel</Section>
          <FieldSelect label="Ancien produit" name="Ancien_produit" value={form.Ancien_produit} onChange={upd} options={ref.Produits} />
          <FieldText label="Mensualité actuelle (Ar)" name="Ancien_Mensualité_TTC" type="number" value={form.Ancien_Mensualité_TTC} onChange={upd} placeholder="0" />
          <FieldText label="Date du contrat" name="Date_Contrat" type="date" value={form.Date_Contrat} onChange={upd} />
          <FieldText label="Réf. produit" name="Réf_produit" value={form['Réf_produit']} onChange={upd} />

          <Section icon={<IconHist size={14} />}>Requête</Section>
          <FieldSelect label="Type de requête" name="Requête_client" value={form.Requête_client} onChange={upd} options={ref.Requetes} req />
          <FieldSelect label="Motif" name="Motif" value={form.Motif} onChange={upd} options={ref.Motifs} />
          <FieldText label="Information libre" name="Information libre" value={form['Information libre']} onChange={upd} placeholder="Note, contexte…" full textarea />

          <Section icon={<IconShield size={14} />}>Traitement & décision</Section>
          <div className="field full">
            <label>Transformation de la demande</label>
            <Transform
              req={form.Requête_client}
              act={form.Action}
              oldM={num(form.Ancien_Mensualité_TTC)}
              newM={num(form.Nouveau_Mensualité_TTC)}
            />
          </div>
          <FieldSelect label="Action" name="Action" value={form.Action} onChange={upd} options={ref.Actions} req />
          <FieldSelect label="Priorité" name="Priorité" value={form.Priorité} onChange={upd} options={priorites} />
          <FieldSelect label="Niveau de décision" name="Niveau décision" value={form['Niveau décision']} onChange={upd} options={ref.Niveaux} req />
          <FieldText label="Date prévue d'exécution" name="Date prévue_Execution" type="date" value={form['Date prévue_Execution']} onChange={upd} />
          <FieldText label="Date de clôture" name="Date_Cloture" type="date" value={form.Date_Cloture} onChange={upd} />
          <FieldSelect label="Agent de confirmation" name="Agent_Confirmation" value={form.Agent_Confirmation} onChange={upd} options={ref.Agents} />

          <Section icon={<IconTrendUp size={14} />}>Nouveau contrat (si client retenu)</Section>
          <FieldSelect label="Nouveau produit" name="Nouveau_produit" value={form.Nouveau_produit} onChange={upd} options={ref.Produits} />
          <FieldText label="Nouvelle mensualité (Ar)" name="Nouveau_Mensualité_TTC" type="number" value={form.Nouveau_Mensualité_TTC} onChange={upd} placeholder="0" />
          <FieldText label="Nouveau nom (transfert)" name="Nouveau_Nom" value={form.Nouveau_Nom} onChange={upd} />
          <FieldText label="Date nouveau contrat" name="Date_Nv_Contrat" type="date" value={form.Date_Nv_Contrat} onChange={upd} />

          {editingId && (
            <>
              <Section icon={<IconHist size={14} />}>Traçabilité de la modification</Section>
              <FieldText
                label="Motif de la modification (commentaire)"
                name="__reason"
                value={form.__reason}
                onChange={upd}
                placeholder="Ex. : le client a changé d'avis fin avril → annulation de la résiliation prévue en mai"
                full
                textarea
              />
            </>
          )}
        </div>
      </form>
    </Modal>
  );
}
