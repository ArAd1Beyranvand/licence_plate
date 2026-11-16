import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'argentina_colors.dart';

/// One ink on one field, the frame in the ink. Digits and letters printed on a
/// coloured band take their colour from the slot, so the ink here is the
/// frame's.
abstract final class ArgentinaThemes {
  static PlateTheme _ink(Color field, Color ink, {bool dark = false}) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        inactive: dark
            ? ArgentinaColors.inactiveOnDark
            : ArgentinaColors.inactiveOnLight,
        borderWidthRatio: 0.03,
        plateRadiusRatio: 0.06,
      );

  /// Mercosur: black on white under the blue band.
  static final PlateTheme standard = _ink(
    ArgentinaColors.mercosurWhite,
    ArgentinaColors.black,
  );

  /// 1995 series: white on black.
  static final PlateTheme legacy = _ink(
    ArgentinaColors.legacyBlack,
    ArgentinaColors.legacyInk,
    dark: true,
  );

  /// Trailer and the 1995 mission plates: a grey face and rim around a band.
  static final PlateTheme banded = _ink(
    ArgentinaColors.missionFace,
    ArgentinaColors.rim,
  );

  /// 1985 consular, special-mission, international and administrative
  /// plates: red on teal.
  static final PlateTheme mission1985 = _ink(
    ArgentinaColors.teal,
    ArgentinaColors.red,
  );

  /// 1985 diplomatic: black on near-white.
  static final PlateTheme diplomatic1985 = _ink(
    ArgentinaColors.diplomaticWhite,
    ArgentinaColors.diplomaticInk,
  );

  /// [PlateSpec.resolveTheme] for `ArgentinaPlates.mission1985`: black on
  /// white for `CD`, red on teal for the other categories.
  static PlateTheme byMission1985(
    PlateTheme base,
    String Function(String key) group,
  ) {
    final t = group('prefix') == 'CD' ? diplomatic1985 : mission1985;
    return base.copyWith(
      plateBackground: t.plateBackground,
      plateBorder: t.plateBorder,
      ink: t.ink,
      dividerColor: t.dividerColor,
      activeColor: t.activeColor,
      inactiveColor: t.inactiveColor,
    );
  }
}
