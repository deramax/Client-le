// App constants ported from ClienTara.html.

export const DEFAULT_THEMES = ['clair', 'sombre', 'bleu', 'vert'];

export const THEME_META = {
  clair: { name: 'Clair', desc: 'Lumineux et épuré, idéal en journée' },
  sombre: { name: 'Sombre', desc: 'Repos visuel, faible luminosité' },
  bleu: { name: 'Bleu Entreprise', desc: 'Corporate, bleu profond' },
  vert: { name: 'Vert Télécom', desc: 'Signature fidélisation, vert' },
};

// Theme preview swatches: [primary, accent, surface, sidebar]
export const THEME_SWATCHES = {
  clair: ['#003087', '#00A86B', '#ffffff', '#0b1a3a'],
  sombre: ['#3b82f6', '#10b981', '#101a2e', '#0a1324'],
  bleu: ['#1e3a8a', '#2563eb', '#ffffff', '#10245c'],
  vert: ['#047857', '#00A86B', '#ffffff', '#06291d'],
};

export const ROLES = [
  { key: 'administrateur', name: 'Administrateur', desc: 'Accès total et inconditionnel', locked: true },
  { key: 'responsable', name: 'Responsable fidélisation', desc: 'Supervision & traitement' },
  { key: 'agent', name: 'Agent de fidélisation', desc: 'Traitement opérationnel des requêtes' },
  { key: 'direction', name: 'Direction', desc: 'Lecture & statistiques, sans modification métier' },
  { key: 'audit', name: 'Audit', desc: 'Lecture seule & accès au journal' },
];

export const roleByKey = (k) => ROLES.find((r) => r.key === k) || ROLES[0];

// Nav modules. navHidden = reachable but not shown in the sidebar nav list.
export const MODULES = [
  { key: 'dashboard', label: 'Tableau de Bord', path: '/' },
  { key: 'visualisation', label: 'Demandes', path: '/demandes' },
  { key: 'clients', label: 'Clients', path: '/clients' },
  { key: 'rapports', label: 'Analyses', path: '/rapports' },
  { key: 'audit', label: 'Audit & Conformité', path: '/audit' },
  { key: 'parametres', label: 'Paramètres', path: '/parametres', section: 'Administration' },
  { key: 'notifications', label: 'Notifications', path: '/notifications', navHidden: true },
  { key: 'journal', label: "Journal d'audit", navHidden: true },
];

export const CAPS = ['view', 'create', 'edit', 'delete'];

export const PAGE_INFO = {
  dashboard: ['Tableau de Bord', "Vue d'ensemble de la fidélisation"],
  visualisation: ['Demandes', 'Liste, recherche et suivi des requêtes clients'],
  clients: ['Clients', 'Fiches clients et historique complet'],
  rapports: ['Analyses', 'Résiliations, équipe, finances & statistiques'],
  audit: ['Audit & Conformité', 'Traçabilité des décisions, journal et contrôles'],
  notifications: ['Notifications', 'Historique complet des alertes'],
  parametres: ['Paramètres', 'Thèmes, rôles, référentiels et données'],
};

export const PRIORITES = ['Faible', 'Normale', 'Haute', 'Critique'];

export const ACTION_BADGE = {
  Résiliation: 'b-danger',
  Refusée: 'b-neutral',
  Basculement: 'b-info',
  Upgrade: 'b-success',
  Downgrade: 'b-info',
  Annulation: 'b-info',
  Réactivation: 'b-success',
  'Changement de Nom': 'b-info',
  'Aucun changement': 'b-neutral',
};
