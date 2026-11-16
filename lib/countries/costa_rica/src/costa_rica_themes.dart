import 'package:flutter/widgets.dart';

import 'package:license_plate/core/plate_core.dart';

import 'costa_rica_colors.dart';

/// The Costa Rican liveries. The frame is 4.3 mm wide (x 2.5..6.8 on the
/// 257 mm-high reference) and its outer corner is square to within ~3 mm.
abstract final class CostaRicaThemes {
  static PlateTheme _livery({
    required Color field,
    required Color ink,
    Color? frame,
    Color inactive = CostaRicaColors.inactiveOnLight,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: frame ?? ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: 4.3 / 257,
    plateRadiusRatio: 3 / 257,
    activeColor: ink,
    inactiveColor: inactive,
  );

  /// Blue on white: private, disabled and motorcycle.
  static final PlateTheme blue = _livery(
    field: CostaRicaColors.white,
    ink: CostaRicaColors.blue,
  );

  /// Black on white: buses and the consular and diplomatic corps.
  static final PlateTheme black = _livery(
    field: CostaRicaColors.white,
    ink: CostaRicaColors.black,
  );

  /// Red on white: commercial, light-load truck, TSJ taxi and official.
  static final PlateTheme red = _livery(
    field: CostaRicaColors.white,
    ink: CostaRicaColors.red,
  );

  /// Green on white: the power executive.
  static final PlateTheme green = _livery(
    field: CostaRicaColors.white,
    ink: CostaRicaColors.green,
  );

  /// Black on a red field, framed in black: the TA taxi.
  static final PlateTheme taxi = _livery(
    field: CostaRicaColors.red,
    ink: CostaRicaColors.black,
    inactive: CostaRicaColors.inactiveOnDark,
  );

  /// Blue on teal: electric vehicles.
  static final PlateTheme electric = _livery(
    field: CostaRicaColors.electricTeal,
    ink: CostaRicaColors.electricInk,
    frame: CostaRicaColors.electricFrame,
    inactive: CostaRicaColors.inactiveOnDark,
  );

  /// Black on yellow: international mission.
  static final PlateTheme mission = _livery(
    field: CostaRicaColors.missionYellow,
    ink: CostaRicaColors.black,
  );

  /// Black on yellow: historical vehicles.
  static final PlateTheme historic = _livery(
    field: CostaRicaColors.historicYellow,
    ink: CostaRicaColors.black,
  );
}
