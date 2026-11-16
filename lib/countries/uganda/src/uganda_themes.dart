import 'package:license_plate/core/plate_core.dart';

import 'uganda_colors.dart';

/// Red ink on a yellow field. The photograph shows no printed frame.
abstract final class UgandaThemes {
  static final PlateTheme police = PlateTheme.monochrome(
    field: UgandaColors.yellow,
    ink: UgandaColors.red,
    borderWidthRatio: 0,
    plateRadiusRatio: 0.05,
  );
}
