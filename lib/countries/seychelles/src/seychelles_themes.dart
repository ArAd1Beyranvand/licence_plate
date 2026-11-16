import 'package:license_plate/core/plate_core.dart';

import 'seychelles_colors.dart';

/// White on black for both generations, no frame (the drawing has none) and
/// corners rounded at 0.12 of the height (measured ~10 units on 82-91).
abstract final class SeychellesThemes {
  static final PlateTheme standard = PlateTheme.monochrome(
    field: SeychellesColors.black,
    ink: SeychellesColors.white,
    inactive: SeychellesColors.inactive,
    borderWidthRatio: 0,
    plateRadiusRatio: 0.12,
  );
}
