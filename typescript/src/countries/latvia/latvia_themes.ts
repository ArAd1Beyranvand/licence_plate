import type { PlateTheme } from 'plate_core';
import { LatviaThemes as themes } from './themes.ts';

export const LatviaThemes = {
  byLetters(base: PlateTheme, group: (key: string) => string): PlateTheme {
    switch (group('letters')) {
      case 'TX':
      case 'TQ':
        return themes.taxi;
      case 'EX':
        return themes.electric;
      default:
        return base;
    }
  },
};
