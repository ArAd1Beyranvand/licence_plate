import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'taiwan_colors.dart';

abstract final class TaiwanThemes {
  static PlateTheme _theme(Color field, Color ink) => PlateTheme.monochrome(
    field: field,
    ink: ink,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.06,
  );

  static final PlateTheme blackOnWhite = _theme(
    TaiwanColors.white,
    TaiwanColors.black,
  );
  static final PlateTheme greenOnWhite = _theme(
    TaiwanColors.white,
    TaiwanColors.green,
  );
  static final PlateTheme redOnWhite = _theme(
    TaiwanColors.white,
    TaiwanColors.red,
  );
  static final PlateTheme whiteOnGreen = _theme(
    TaiwanColors.green,
    TaiwanColors.white,
  );
  static final PlateTheme whiteOnRed = _theme(
    TaiwanColors.red,
    TaiwanColors.white,
  );
  static final PlateTheme blackOnYellow = _theme(
    TaiwanColors.yellow,
    TaiwanColors.black,
  );
}
