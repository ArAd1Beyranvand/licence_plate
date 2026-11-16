import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'morocco_colors.dart';

/// One ink on one field with a rim. Rim ratios are of the canvas height,
/// measured off the artwork (thin black outline ~2 of 110; the heavier
/// outline of the W18, WW, protection and diplomatic plates ~3 of 110). The
/// corner radius is an estimate.
abstract final class MoroccoThemes {
  static PlateTheme _livery({
    required Color field,
    required Color ink,
    required Color inactive,
    Color? rim,
    double border = 0.02,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: rim ?? ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: border,
    plateRadiusRatio: 0.06,
    activeColor: ink,
    inactiveColor: inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  /// Black on white: registration, service and protection plates, WW.
  static final PlateTheme standard = _livery(
    field: MoroccoColors.white,
    ink: MoroccoColors.black,
    inactive: MoroccoColors.inactiveOnLight,
  );

  /// White on red, no visible rim.
  static final PlateTheme trailer = _livery(
    field: MoroccoColors.red,
    ink: MoroccoColors.white,
    inactive: MoroccoColors.inactiveOnDark,
  );

  /// Red on white with a red rim.
  static final PlateTheme dealer = _livery(
    field: MoroccoColors.white,
    ink: MoroccoColors.red,
    inactive: MoroccoColors.inactiveOnLight,
    border: 0.03,
  );

  static final PlateTheme diplomatic = _livery(
    field: MoroccoColors.yellow,
    ink: MoroccoColors.black,
    inactive: MoroccoColors.inactiveOnLight,
    border: 0.03,
  );

  /// White on black inside a white rim.
  static final PlateTheme military = _livery(
    field: MoroccoColors.black,
    ink: MoroccoColors.white,
    inactive: MoroccoColors.inactiveOnDark,
    rim: MoroccoColors.white,
    border: 0.041,
  );

  static final PlateTheme navy = _livery(
    field: MoroccoColors.navyBlue,
    ink: MoroccoColors.navyInk,
    inactive: MoroccoColors.inactiveOnDark,
    rim: MoroccoColors.navyInk,
    border: 0.041,
  );
}
