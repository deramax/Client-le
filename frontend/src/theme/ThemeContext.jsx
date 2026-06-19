// Theme management: sets document.documentElement.dataset.theme, persists in
// localStorage (cta_theme, default 'clair').
import { createContext, useCallback, useContext, useEffect, useState } from 'react';
import { DEFAULT_THEMES, THEME_META } from '../lib/constants.js';

const ThemeCtx = createContext(null);
const KEY = 'cta_theme';

function initialTheme() {
  const saved = localStorage.getItem(KEY);
  return DEFAULT_THEMES.includes(saved) ? saved : 'clair';
}

export function ThemeProvider({ children }) {
  const [theme, setThemeState] = useState(initialTheme);

  useEffect(() => {
    document.documentElement.dataset.theme = theme;
    localStorage.setItem(KEY, theme);
  }, [theme]);

  const setTheme = useCallback((t) => {
    if (DEFAULT_THEMES.includes(t)) setThemeState(t);
  }, []);

  const cycleTheme = useCallback(() => {
    setThemeState((cur) => {
      const i = DEFAULT_THEMES.indexOf(cur);
      return DEFAULT_THEMES[(i + 1) % DEFAULT_THEMES.length];
    });
  }, []);

  return (
    <ThemeCtx.Provider value={{ theme, setTheme, cycleTheme, meta: THEME_META }}>
      {children}
    </ThemeCtx.Provider>
  );
}

export function useTheme() {
  return useContext(ThemeCtx);
}
