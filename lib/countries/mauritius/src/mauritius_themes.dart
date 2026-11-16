import 'package:license_plate/core/plate_core.dart';

import 'mauritius_colors.dart';

/// Silver characters on black, no frame (the photo shows none) and nearly
/// square corners (radius 0.03, an estimate).
abstract final class MauritiusThemes {
  static final PlateTheme government = PlateTheme.monochrome(
    field: MauritiusColors.black,
    ink: MauritiusColors.silver,
    inactive: MauritiusColors.inactive,
    borderWidthRatio: 0,
    plateRadiusRatio: 0.03,
  );
}
