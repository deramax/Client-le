import { IconSearch } from './Icons.jsx';

export default function Empty({ children, icon = true }) {
  return (
    <div className="empty">
      {icon ? <IconSearch size={42} sw={1.6} /> : null}
      <div>{children}</div>
    </div>
  );
}
