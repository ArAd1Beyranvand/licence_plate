import 'package:license_plate/core/plate_core.dart';

import 'french_guiana_colors.dart';

abstract final class FrenchGuianaThemes {
  static final PlateTheme private = PlateTheme.monochrome(
    field: FrenchGuianaColors.white,
    ink: FrenchGuianaColors.black,
    borderWidthRatio: 0.0227,
    plateRadiusRatio: 0.05,
  );
}
