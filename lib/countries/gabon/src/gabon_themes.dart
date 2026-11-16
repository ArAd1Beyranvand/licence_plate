import 'package:license_plate/core/plate_core.dart';

import 'gabon_colors.dart';

abstract final class GabonThemes {
  static final PlateTheme private = PlateTheme.monochrome(
    field: GabonColors.yellow,
    ink: GabonColors.black,
    inactive: GabonColors.inactive,
    borderWidthRatio: 0.025,
    plateRadiusRatio: 0.09,
  );
}
