import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ascension_island_colors.dart';

abstract final class AscensionIslandThemes {
  static PlateTheme _theme(Color field) => PlateTheme.monochrome(
    field: field,
    ink: AscensionIslandColors.black,
    borderWidthRatio: 0,
    plateRadiusRatio: 0.02,
  );

  static final PlateTheme front = _theme(AscensionIslandColors.white);
  static final PlateTheme rear = _theme(AscensionIslandColors.yellow);
}
