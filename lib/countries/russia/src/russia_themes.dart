import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'russia_colors.dart';

abstract final class RussiaThemes {
  static PlateTheme _field(
    Color field,
    Color ink,
    Color inactive, {
    double border = 0.02,
    double radius = 0.05,
  }) => PlateTheme.monochrome(
    field: field,
    ink: ink,
    inactive: inactive,
    borderWidthRatio: border,
    plateRadiusRatio: radius,
  );

  static final PlateTheme private = _field(
    RussiaColors.white,
    RussiaColors.black,
    RussiaColors.inactiveOnLight,
  );

  static final PlateTheme trailer = private;

  static final PlateTheme exported = private;

  /// Thick black frame: the plate is laminated paper.
  static final PlateTheme transit = _field(
    RussiaColors.white,
    RussiaColors.black,
    RussiaColors.inactiveOnLight,
    border: 0.045,
    radius: 0.07,
  );

  static final PlateTheme taxi = _field(
    RussiaColors.taxiYellow,
    RussiaColors.black,
    RussiaColors.inactiveOnLight,
  );

  static final PlateTheme police = _field(
    RussiaColors.policeBlue,
    RussiaColors.white,
    RussiaColors.inactiveOnDark,
  );

  static final PlateTheme diplomatic = _field(
    RussiaColors.diplomaticRed,
    RussiaColors.white,
    RussiaColors.inactiveOnDark,
  );

  static final PlateTheme military = _field(
    RussiaColors.militaryField,
    RussiaColors.white,
    RussiaColors.inactiveOnDark,
  );

  static final PlateTheme motorcycle = private;
}
