import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'falkland_islands_colors.dart';

abstract final class FalklandIslandsThemes {
  static PlateTheme _theme(Color field) => PlateTheme.monochrome(
    field: field,
    ink: FalklandIslandsColors.black,
    borderWidthRatio: 0,
    plateRadiusRatio: 0.02,
  );

  static final PlateTheme front = _theme(FalklandIslandsColors.white);
  static final PlateTheme rear = _theme(FalklandIslandsColors.yellow);
}
