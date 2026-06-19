// Status / action / outcome badges (ported from ClienTara.html).
import { ACTION_BADGE } from '../lib/constants.js';
import { isPending, isResilie } from '../lib/demande.js';

export function DecisionBadge({ d }) {
  return isPending(d) ? (
    <span className="badge b-pending">En attente</span>
  ) : (
    <span className="badge b-closed">Clôturé</span>
  );
}

export function ActionBadge({ action }) {
  const cls = ACTION_BADGE[action] || 'b-neutral';
  return <span className={`badge ${cls}`}>{action || '—'}</span>;
}

export function OutcomeBadge({ d }) {
  return isResilie(d) ? (
    <span className="badge b-danger">Résilié</span>
  ) : (
    <span className="badge b-success">Retenu</span>
  );
}
