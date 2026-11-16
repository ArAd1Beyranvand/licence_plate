import 'package:license_plate/core/plate_core.dart';

import 'eswatini_colors.dart';

abstract final class EswatiniThemes {
  /// Dark grey-brown on pale field, frame in the ink colour. Front and rear
  /// plates share it.
  static final PlateTheme standard = PlateTheme.monochrome(
    field: EswatiniColors.field,
    ink: EswatiniColors.ink,
    borderWidthRatio: 0.03,
    plateRadiusRatio: 0.09,
  );
}
