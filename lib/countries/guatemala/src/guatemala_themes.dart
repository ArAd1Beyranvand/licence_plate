import 'package:license_plate/core/plate_core.dart';

import 'guatemala_colors.dart';

/// Black on white, no frame; the corner radius is estimated.
abstract final class GuatemalaThemes {
  static final PlateTheme private = PlateTheme.monochrome(
    field: GuatemalaColors.white,
    ink: GuatemalaColors.black,
    borderWidthRatio: 0,
    plateRadiusRatio: 0.04,
  );
}
