import { initials } from '../lib/format.js';

export default function Avatar({ name, photo, size = 32, radius = 9, style = {}, className = '' }) {
  const base = {
    width: size,
    height: size,
    borderRadius: radius,
    fontSize: Math.max(10, Math.round(size * 0.36)),
    ...style,
  };
  if (photo) {
    return (
      <span
        className={`avatar ${className}`}
        style={{ ...base, backgroundImage: `url(${photo})`, backgroundSize: 'cover', backgroundPosition: 'center' }}
      />
    );
  }
  return (
    <span className={`avatar ${className}`} style={base}>
      {initials(name)}
    </span>
  );
}
