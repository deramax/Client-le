// Chart.js registration + shared option builders (ported from ClienTara.html).
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  LineElement,
  PointElement,
  ArcElement,
  Tooltip,
  Legend,
  Filler,
} from 'chart.js';
import { money, moneyShort } from './format.js';

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  LineElement,
  PointElement,
  ArcElement,
  Tooltip,
  Legend,
  Filler
);

ChartJS.defaults.font.family = 'Inter, sans-serif';
ChartJS.defaults.font.size = 11.5;

export function cssVar(n) {
  return getComputedStyle(document.documentElement).getPropertyValue(n).trim();
}

// Re-read theme colors at render time so charts follow the active theme.
export function themeColors() {
  return {
    grid: cssVar('--border'),
    text: cssVar('--text-2'),
    primary: cssVar('--primary') || '#1b3a8f',
    accent: cssVar('--accent') || '#00a06a',
    danger: '#dc2626',
  };
}

export function baseOptions({ legend = false, moneyAxis = false } = {}) {
  const { grid, text } = themeColors();
  return {
    responsive: true,
    maintainAspectRatio: false,
    color: text,
    plugins: {
      legend: legend
        ? { position: 'bottom', labels: { usePointStyle: true, boxWidth: 8, padding: 14 } }
        : { display: false },
      tooltip: {
        callbacks: moneyAxis
          ? { label: (c) => c.dataset.label + ': ' + money(c.parsed.y) }
          : {},
      },
    },
    scales: {
      x: { grid: { display: false }, border: { display: false } },
      y: {
        beginAtZero: true,
        grid: { color: grid },
        border: { display: false },
        ticks: moneyAxis ? { callback: (v) => moneyShort(v) } : undefined,
      },
    },
  };
}

export const PALETTE = [
  '#6366f1', '#10b981', '#dc2626', '#d97706', '#7c3aed',
  '#0891b2', '#db2777', '#65a30d', '#64748b', '#0ea5e9',
];
