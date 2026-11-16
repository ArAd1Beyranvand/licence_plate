import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'south_sudan_colors.dart';

/// One ink on a white field, the frame in the ink. Border and corner ratios
/// are not measured; the photographs show a thin rim and slightly rounded
/// corners.
abstract final class SouthSudanThemes {
  static final PlateTheme private = _ink(SouthSudanColors.ink);
  static final PlateTheme taxi = _ink(SouthSudanColors.taxiInk);
}

PlateTheme _ink(Color ink) => PlateTheme.monochrome(
  field: SouthSudanColors.white,
  ink: ink,
  borderWidthRatio: 0.015,
  plateRadiusRatio: 0.06,
);
