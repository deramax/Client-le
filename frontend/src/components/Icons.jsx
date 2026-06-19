// SVG icons ported from ClienTara.html. Each is a small functional component.
// `size` controls width/height (default 18 to match .iconbtn/.btn svg sizing).

const S = ({ size = 18, children, fill = 'none', stroke = 'currentColor', sw = 2, ...rest }) => (
  <svg
    viewBox="0 0 24 24"
    width={size}
    height={size}
    fill={fill}
    stroke={stroke}
    strokeWidth={sw}
    {...rest}
  >
    {children}
  </svg>
);

export const IconDoc = (p) => (
  <S {...p}>
    <path d="M14 3H7a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V8l-5-5Z" />
    <path d="M14 3v5h5M9 13h6M9 17h6" />
  </S>
);
export const IconClock = (p) => (
  <S {...p}>
    <circle cx="12" cy="12" r="9" />
    <path d="M12 7v5l3 2" strokeLinecap="round" />
  </S>
);
export const IconShield = (p) => (
  <S {...p}>
    <path d="M12 3 4 6v6c0 5 3.4 8.6 8 10 4.6-1.4 8-5 8-10V6l-8-3Z" />
    <path d="m9 12 2 2 4-4" strokeLinecap="round" strokeLinejoin="round" />
  </S>
);
export const IconExit = (p) => (
  <S {...p}>
    <path
      d="M16 17l5-5-5-5M21 12H9M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"
      strokeLinecap="round"
      strokeLinejoin="round"
    />
  </S>
);
export const IconCash = (p) => (
  <S {...p}>
    <rect x="2" y="6" width="20" height="12" rx="2" />
    <circle cx="12" cy="12" r="2.5" />
    <path d="M6 12h.01M18 12h.01" strokeLinecap="round" />
  </S>
);
export const IconTrendUp = (p) => (
  <S {...p}>
    <path d="m3 17 6-6 4 4 8-8M21 7h-5M21 7v5" strokeLinecap="round" strokeLinejoin="round" />
  </S>
);
export const IconTrendDn = (p) => (
  <S {...p}>
    <path d="m3 7 6 6 4-4 8 8M21 17h-5M21 17v-5" strokeLinecap="round" strokeLinejoin="round" />
  </S>
);
export const IconUser = (p) => (
  <S {...p}>
    <path d="M19 20c0-3.3-3.1-5-7-5s-7 1.7-7 5M12 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8Z" strokeLinecap="round" />
  </S>
);
export const IconHist = (p) => (
  <S {...p}>
    <path d="M3 12a9 9 0 1 0 3-6.7L3 8M3 4v4h4M12 8v4l3 2" strokeLinecap="round" strokeLinejoin="round" />
  </S>
);
export const IconSearch = (p) => (
  <S {...p}>
    <circle cx="11" cy="11" r="7" />
    <path d="m20 20-3.5-3.5" strokeLinecap="round" />
  </S>
);
export const IconBell = (p) => (
  <S {...p}>
    <path
      d="M18 8a6 6 0 1 0-12 0c0 7-3 9-3 9h18s-3-2-3-9M13.7 21a2 2 0 0 1-3.4 0"
      strokeLinecap="round"
      strokeLinejoin="round"
    />
  </S>
);
export const IconTheme = (p) => (
  <S {...p}>
    <circle cx="12" cy="12" r="9" />
    <path d="M12 3a9 9 0 0 0 0 18c1.7 0 2-1.3 1-2.3-.8-.9-.3-2.2 1-2.2h1.5A3.5 3.5 0 0 0 20 13c0-5-3.6-10-8-10Z" />
    <circle cx="8" cy="10" r="1" fill="currentColor" />
    <circle cx="12" cy="7.5" r="1" fill="currentColor" />
    <circle cx="16" cy="10" r="1" fill="currentColor" />
  </S>
);
export const IconLogout = (p) => (
  <S {...p}>
    <path
      d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9"
      strokeLinecap="round"
      strokeLinejoin="round"
    />
  </S>
);
export const IconList = (p) => (
  <S {...p}>
    <path d="M8 6h13M8 12h13M8 18h13M3 6h.01M3 12h.01M3 18h.01" strokeLinecap="round" />
  </S>
);
export const IconDb = (p) => (
  <S {...p}>
    <ellipse cx="12" cy="5" rx="8" ry="3" />
    <path d="M4 5v6c0 1.7 3.6 3 8 3s8-1.3 8-3V5M4 11v6c0 1.7 3.6 3 8 3s8-1.3 8-3v-6" />
  </S>
);
export const IconDownload = (p) => (
  <S {...p}>
    <path d="M12 3v12m0 0 4-4m-4 4-4-4M4 21h16" strokeLinecap="round" strokeLinejoin="round" />
  </S>
);
export const IconClose = (p) => (
  <S {...p}>
    <path d="M18 6 6 18M6 6l12 12" strokeLinecap="round" />
  </S>
);
export const IconChevron = (p) => (
  <S {...p}>
    <path d="m9 6 6 6-6 6" strokeLinecap="round" strokeLinejoin="round" />
  </S>
);
export const IconPlus = (p) => (
  <S {...p}>
    <path d="M12 5v14M5 12h14" strokeLinecap="round" />
  </S>
);
export const IconCheck = (p) => (
  <S sw={2.4} {...p}>
    <path d="M20 6 9 17l-5-5" strokeLinecap="round" strokeLinejoin="round" />
  </S>
);
export const IconMenu = (p) => (
  <S {...p}>
    <path d="M3 6h18M3 12h18M3 18h18" strokeLinecap="round" />
  </S>
);
export const IconEdit = (p) => (
  <S {...p}>
    <path d="M12 20h9M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4 12.5-12.5Z" strokeLinecap="round" strokeLinejoin="round" />
  </S>
);
export const IconTrash = (p) => (
  <S {...p}>
    <path d="M3 6h18M8 6V4h8v2M19 6l-1 14H6L5 6M10 11v6M14 11v6" strokeLinecap="round" strokeLinejoin="round" />
  </S>
);

// Nav icons keyed by module (filled style, matching legacy NAV_ICONS).
export function NavIcon({ name, size = 20 }) {
  const common = { viewBox: '0 0 24 24', width: size, height: size };
  switch (name) {
    case 'dashboard':
      return (
        <svg {...common} fill="currentColor">
          <path d="M3 13h8V3H3v10Zm0 8h8v-6H3v6Zm10 0h8V11h-8v10Zm0-18v6h8V3h-8Z" />
        </svg>
      );
    case 'visualisation':
      return (
        <svg {...common} fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          <path d="M3 3v18h18M8 14l3-3 3 2 4-5" />
        </svg>
      );
    case 'clients':
      return (
        <svg {...common} fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
          <path d="M16 19c0-2.8-1.8-4-4-4s-4 1.2-4 4M12 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z" />
          <path d="M20 8v6M23 11h-6" />
        </svg>
      );
    case 'rapports':
      return (
        <svg {...common} fill="none" stroke="currentColor" strokeWidth="2">
          <path d="M7 16v-5M12 16V8M17 16v-3" strokeWidth="2.2" strokeLinecap="round" />
          <rect x="3" y="3" width="18" height="18" rx="3" />
        </svg>
      );
    case 'audit':
      return (
        <svg {...common} fill="none" stroke="currentColor" strokeWidth="1.8">
          <path d="M9 4h6a1 1 0 0 1 1 1v1h2a1 1 0 0 1 1 1v13a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h2V5a1 1 0 0 1 1-1Z" />
          <path d="m8.5 13 2 2 4.5-4.5" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      );
    case 'parametres':
      return (
        <svg {...common} fill="none" stroke="currentColor" strokeWidth="1.7">
          <circle cx="12" cy="12" r="3" strokeWidth="2" />
          <path d="M19.4 15a1.6 1.6 0 0 0 .3 1.8l.1.1a2 2 0 1 1-2.8 2.8l-.1-.1a1.6 1.6 0 0 0-2.7.7 1.6 1.6 0 0 0-1 1.5V22a2 2 0 0 1-4 0v-.1a1.6 1.6 0 0 0-1.1-1.5 1.6 1.6 0 0 0-1.8.3l-.1.1a2 2 0 1 1-2.8-2.8l.1-.1a1.6 1.6 0 0 0 .3-1.8 1.6 1.6 0 0 0-1.5-1H2a2 2 0 0 1 0-4h.1a1.6 1.6 0 0 0 1.5-1.1 1.6 1.6 0 0 0-.3-1.8l-.1-.1A2 2 0 1 1 5.9 4.2l.1.1a1.6 1.6 0 0 0 1.8.3H8a1.6 1.6 0 0 0 1-1.5V2a2 2 0 0 1 4 0v.1a1.6 1.6 0 0 0 1 1.5 1.6 1.6 0 0 0 1.8-.3l.1-.1a2 2 0 1 1 2.8 2.8l-.1.1a1.6 1.6 0 0 0-.3 1.8V8a1.6 1.6 0 0 0 1.5 1H22a2 2 0 0 1 0 4h-.1a1.6 1.6 0 0 0-1.5 1Z" />
        </svg>
      );
    case 'notifications':
      return <IconBell size={size} />;
    default:
      return <IconDoc size={size} />;
  }
}
