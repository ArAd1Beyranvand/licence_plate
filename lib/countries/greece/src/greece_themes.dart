import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'greece_colors.dart';

abstract final class GreeceThemes {
  static PlateTheme _field(
    Color field,
    Color ink,
    Color inactive,
    double border,
    double radius,
  ) => PlateTheme.monochrome(
    field: field,
    ink: ink,
    inactive: inactive,
    borderWidthRatio: border,
    plateRadiusRatio: radius,
  );

  static final PlateTheme private = _field(
    GreeceColors.white,
    GreeceColors.black,
    GreeceColors.inactiveOnLight,
    0.036,
    0.06,
  );

  static final PlateTheme trailer = _field(
    GreeceColors.trailerGrey,
    GreeceColors.black,
    GreeceColors.inactiveOnLight,
    0.036,
    0.06,
  );

  static final PlateTheme government = _field(
    GreeceColors.governmentOrange,
    GreeceColors.governmentInk,
    GreeceColors.inactiveOnDark,
    0.036,
    0.06,
  );

  static final PlateTheme police = _field(
    GreeceColors.policeField,
    GreeceColors.policeBlue,
    GreeceColors.inactiveOnLight,
    0.02,
    0.05,
  );

  static final PlateTheme afg = _field(
    GreeceColors.afgField,
    GreeceColors.afgInk,
    GreeceColors.inactiveOnLight,
    0.03,
    0.07,
  );
}
