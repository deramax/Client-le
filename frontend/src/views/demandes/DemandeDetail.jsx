// Detail modal for a single demande, with permission-gated actions.
import Modal from '../../components/Modal.jsx';
import Avatar from '../../components/Avatar.jsx';
import { ActionBadge, DecisionBadge, OutcomeBadge } from '../../components/Badges.jsx';
import { useAuth } from '../../auth/AuthContext.jsx';
import { fmtDate, money } from '../../lib/format.js';
import { isResilie, montAncien, montNouveau } from '../../lib/demande.js';
import { IconDoc, IconCash, IconShield, IconTrendUp, IconUser } from '../../components/Icons.jsx';

function Cell({ label, children }) {
  return (
    <div className="det-cell">
      <div className="dl">{label}</div>
      <div className="dv">{children || '—'}</div>
    </div>
  );
}

function DetSection({ icon, children }) {
  return (
    <div className="det-section">
      <span className="di">{icon}</span> {children}
    </div>
  );
}

export default function DemandeDetail({ d, onClose, onEdit, onDelete, onCancelResil, onOpenClient }) {
  const { can } = useAuth();
  const hasNouveau = d.Nouveau_produit || montNouveau(d) || d.Nouveau_Nom;

  const footer = (
    <>
      <button className="btn btn-ghost" onClick={() => onOpenClient(d.Refnum)}>
        <IconUser size={16} /> Fiche client
      </button>
      {can('visualisation', 'edit') && isResilie(d) && (
        <button className="btn btn-ghost" onClick={() => onCancelResil(d)}>
          Annuler la résiliation
        </button>
      )}
      {can('visualisation', 'delete') && (
        <button className="btn btn-danger" onClick={() => onDelete(d)}>
          Supprimer
        </button>
      )}
      {can('visualisation', 'edit') && (
        <button className="btn btn-primary" onClick={() => onEdit(d)}>
          Modifier
        </button>
      )}
    </>
  );

  return (
    <Modal
      title="Détail de la requête"
      sub={`${d.Requête_client || ''} · ${d.Action || ''}`}
      size="wide"
      onClose={onClose}
      footer={footer}
    >
      <div style={{ display: 'flex', alignItems: 'center', gap: 13, marginBottom: 16, flexWrap: 'wrap' }}>
        <Avatar name={d.Nom_Client} size={48} radius={14} />
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ fontFamily: 'var(--font-display)', fontSize: 17, fontWeight: 600 }}>{d.Nom_Client}</div>
          <div className="cell-sub">
            Réf {d.Refnum} · {d.id}
          </div>
        </div>
        <OutcomeBadge d={d} /> <DecisionBadge d={d} />
      </div>

      <DetSection icon={<IconDoc size={15} />}>Réception & client</DetSection>
      <div className="det-grid">
        <Cell label="Date de réception">{fmtDate(d['Date de réception'])}</Cell>
        <Cell label="Site">{d.Site}</Cell>
        <Cell label="Agent de fidélisation">{d.Agent_fidélisation}</Cell>
        <Cell label="Technologie">{d.Technologie}</Cell>
      </div>

      <DetSection icon={<IconCash size={15} />}>Contrat & requête</DetSection>
      <div className="det-grid">
        <Cell label="Ancien produit">{d.Ancien_produit}</Cell>
        <Cell label="Mensualité actuelle">{montAncien(d) ? money(montAncien(d)) : '—'}</Cell>
        <Cell label="Date du contrat">{fmtDate(d.Date_Contrat)}</Cell>
        <Cell label="Type de requête">{d.Requête_client}</Cell>
        <Cell label="Motif">{d.Motif}</Cell>
        <Cell label="Information libre">{d['Information libre']}</Cell>
      </div>

      <DetSection icon={<IconShield size={15} />}>Traitement & décision</DetSection>
      <div className="det-grid">
        <Cell label="Action">
          <ActionBadge action={d.Action} />
        </Cell>
        <Cell label="Niveau de décision">{d['Niveau décision']}</Cell>
        <Cell label="Date prévue d'exécution">{fmtDate(d['Date prévue_Execution'])}</Cell>
        <Cell label="Date de clôture">{fmtDate(d.Date_Cloture)}</Cell>
        <Cell label="Agent de confirmation">{d.Agent_Confirmation}</Cell>
        <Cell label="—">{''}</Cell>
      </div>

      {hasNouveau ? (
        <>
          <DetSection icon={<IconTrendUp size={15} />}>Nouveau contrat</DetSection>
          <div className="det-grid">
            <Cell label="Nouveau produit">{d.Nouveau_produit}</Cell>
            <Cell label="Nouvelle mensualité">{montNouveau(d) ? money(montNouveau(d)) : '—'}</Cell>
            <Cell label="Nouveau nom">{d.Nouveau_Nom}</Cell>
            <Cell label="Date nouveau contrat">{fmtDate(d.Date_Nv_Contrat)}</Cell>
          </div>
        </>
      ) : null}
    </Modal>
  );
}
