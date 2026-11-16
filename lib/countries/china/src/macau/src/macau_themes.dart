import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'macau_colors.dart';

abstract final class MacauThemes {
  static PlateTheme _theme(
    Color field,
    Color ink,
    Color inactive,
    double radius,
  ) => PlateTheme.monochrome(
    field: field,
    ink: ink,
    inactive: inactive,
    borderWidthRatio: 0,
    plateRadiusRatio: radius,
  );

  static final PlateTheme private = _theme(
    MacauColors.black,
    MacauColors.white,
    MacauColors.inactiveOnDark,
    0.12,
  );
  static final PlateTheme yellow = _theme(
    MacauColors.black,
    MacauColors.yellow,
    MacauColors.inactiveOnDark,
    0.12,
  );
  static final PlateTheme privateSquare = _theme(
    MacauColors.black,
    MacauColors.white,
    MacauColors.inactiveOnDark,
    0.08,
  );
  static final PlateTheme yellowSquare = _theme(
    MacauColors.black,
    MacauColors.yellow,
    MacauColors.inactiveOnDark,
    0.08,
  );
  static final PlateTheme moped = PlateTheme.monochrome(
    field: MacauColors.white,
    ink: MacauColors.black,
    inactive: MacauColors.inactiveOnLight,
    borderWidthRatio: 0.03,
    plateRadiusRatio: 0.08,
  );
  static final PlateTheme mainland = _theme(
    MacauColors.black,
    MacauColors.white,
    MacauColors.inactiveOnDark,
    0.04,
  );
}
