// "Importer depuis 4D" — searches the 4D portal and prefills a new request.
// Ports ouvrirRecherche4D / run4DSearch / importer4D from the legacy snippet.
import { useEffect, useRef, useState } from 'react';
import Modal from '../../components/Modal.jsx';
import api from '../../api/client.js';
import { useToast } from '../../components/Toast.jsx';
import { dossier4DToPrefill } from '../../lib/demande.js';
import { IconSearch } from '../../components/Icons.jsx';

export default function FourdImport({ onClose, onImport }) {
  const toast = useToast();
  const [q, setQ] = useState('');
  const [results, setResults] = useState(null);
  const [busy, setBusy] = useState(false);
  const inputRef = useRef(null);

  useEffect(() => {
    inputRef.current?.focus();
  }, []);

  const search = async () => {
    setBusy(true);
    try {
      const d = await api.get('/fourd/clients/search?q=' + encodeURIComponent(q || ''));
      setResults(d.results || []);
    } catch (e) {
      toast(e.message || 'Recherche indisponible');
      setResults([]);
    } finally {
      setBusy(false);
    }
  };

  const choose = async (refnum) => {
    try {
      const dos = await api.get('/fourd/clients/' + encodeURIComponent(refnum));
      if (!dos || !dos.found) {
        toast('Client introuvable');
        return;
      }
      onImport(dossier4DToPrefill(dos));
      toast('Informations client importées depuis 4D');
      onClose();
    } catch (e) {
      toast(e.message || 'Lecture indisponible');
    }
  };

  return (
    <Modal
      title="Rechercher un client (serveur 4D)"
      sub="Génère automatiquement le dossier client et pré-remplit la requête"
      onClose={onClose}
      footer={<button className="btn btn-ghost" onClick={onClose}>Fermer</button>}
    >
      <div className="search" style={{ position: 'relative', marginBottom: 12 }}>
        <IconSearch className="si" size={17} />
        <input
          ref={inputRef}
          type="text"
          placeholder="Refnum ou nom du client"
          value={q}
          onChange={(e) => setQ(e.target.value)}
          onKeyDown={(e) => e.key === 'Enter' && search()}
          style={{ width: '100%' }}
        />
      </div>
      <button className="btn btn-primary btn-sm" onClick={search} disabled={busy}>
        {busy ? 'Recherche…' : 'Rechercher'}
      </button>

      <div style={{ marginTop: 14 }}>
        {results === null && <div className="cell-sub">Saisissez un Refnum ou un nom, puis lancez la recherche.</div>}
        {results !== null && results.length === 0 && <div className="empty">Aucun client trouvé.</div>}
        {results &&
          results.map((c) => (
            <div
              key={c.refnum}
              className="card"
              style={{ padding: '10px 13px', marginBottom: 8, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 10 }}
              onClick={() => choose(c.refnum)}
            >
              <div style={{ flex: 1, minWidth: 0 }}>
                <div className="cell-strong">{c.nom || '(sans nom)'}</div>
                <div className="cell-sub">Refnum {c.refnum}</div>
              </div>
              <span className="badge b-info">Importer</span>
            </div>
          ))}
      </div>
    </Modal>
  );
}
