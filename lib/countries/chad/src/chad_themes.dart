import 'package:license_plate/core/plate_core.dart';

import 'chad_colors.dart';

/// Black on white and light on red. Frame and corner ratios are read off the
/// regular photo (a heavy rounded frame); the temporary photo shows only a
/// thin rim, so it gets a thinner one. Neither is measured to the pixel.
abstract final class ChadThemes {
  static final PlateTheme private = PlateTheme.monochrome(
    field: ChadColors.white,
    ink: ChadColors.black,
    borderWidthRatio: 0.03,
    plateRadiusRatio: 0.08,
  );

  static final PlateTheme temporary = PlateTheme.monochrome(
    field: ChadColors.red,
    ink: ChadColors.paintedWhite,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.04,
  );
}
