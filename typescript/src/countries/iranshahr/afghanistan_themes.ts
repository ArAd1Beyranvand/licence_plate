import type { PlateTheme } from 'plate_core';
import { AfghanistanThemes as Liveries } from './themes.ts';

export const AfghanistanThemes = {
  /** Taxi and bus (`ت`, `ب`) print on transport, every other class on civilian, keeping base's rim and corner. */
  byClass(base: PlateTheme, group: (key: string) => string): PlateTheme {
    const t = group('class') === 'T' || group('class') === 'B' ? Liveries.transport : Liveries.civilian;
    return base.copyWith({
      plateBackground: t.plateBackground,
      plateBorder: t.plateBorder,
      ink: t.ink,
      dividerColor: t.dividerColor,
      activeColor: t.activeColor,
      inactiveColor: t.inactiveColor,
    });
  },
};
