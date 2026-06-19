// Generic modal matching legacy .modal-ov / .modal markup. Closes on overlay
// mousedown and Escape. `size` can be '', 'wide'.
import { useEffect, useRef } from 'react';
import { IconClose } from './Icons.jsx';

export default function Modal({ title, sub, size = '', onClose, footer, children }) {
  const overlayRef = useRef(null);

  useEffect(() => {
    const onKey = (e) => {
      if (e.key === 'Escape') onClose();
    };
    document.addEventListener('keydown', onKey);
    return () => document.removeEventListener('keydown', onKey);
  }, [onClose]);

  return (
    <div
      className="modal-ov show"
      ref={overlayRef}
      onMouseDown={(e) => {
        if (e.target === overlayRef.current) onClose();
      }}
    >
      <div className={`modal${size ? ' ' + size : ''}`}>
        <div className="modal-h">
          <div>
            <h3>{title}</h3>
            {sub ? <p>{sub}</p> : null}
          </div>
          <button className="x" onClick={onClose} aria-label="Fermer">
            <IconClose size={17} sw={2.2} />
          </button>
        </div>
        <div className="modal-b">{children}</div>
        {footer ? <div className="modal-f">{footer}</div> : null}
      </div>
    </div>
  );
}
