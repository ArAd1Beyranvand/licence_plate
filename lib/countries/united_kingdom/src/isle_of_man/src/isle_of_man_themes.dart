import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'isle_of_man_colors.dart';

/// One ink on one field. Only the yellow reference prints a frame.
abstract final class IsleOfManThemes {
  static PlateTheme _mono(
    Color field,
    Color ink,
    Color inactive, {
    double border = 0,
  }) => PlateTheme.monochrome(
    field: field,
    ink: ink,
    inactive: inactive,
    borderWidthRatio: border,
    plateRadiusRatio: 0.04,
  );

  static final PlateTheme front = _mono(
    IsleOfManColors.white,
    IsleOfManColors.black,
    IsleOfManColors.inactiveOnLight,
  );

  static final PlateTheme rear = _mono(
    IsleOfManColors.yellow,
    IsleOfManColors.black,
    IsleOfManColors.inactiveOnLight,
    border: 0.012,
  );

  /// White on black, allowed for vehicles built before 1 February 1990.
  static final PlateTheme classic = _mono(
    IsleOfManColors.classicField,
    IsleOfManColors.white,
    IsleOfManColors.inactiveOnDark,
  );
}
