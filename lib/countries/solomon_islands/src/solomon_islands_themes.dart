import 'package:license_plate/core/plate_core.dart';

import 'solomon_islands_colors.dart';

abstract final class SolomonIslandsThemes {
  /// Black on orange, the frame in the ink. The rim is ~1.2 of the 50-unit
  /// height; the radius is not measured.
  static final PlateTheme private = PlateTheme.monochrome(
    field: SolomonIslandsColors.field,
    ink: SolomonIslandsColors.ink,
    inactive: SolomonIslandsColors.inactive,
    borderWidthRatio: 0.025,
    plateRadiusRatio: 0.04,
  );
}
