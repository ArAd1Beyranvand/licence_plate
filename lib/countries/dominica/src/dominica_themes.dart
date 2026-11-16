import 'package:license_plate/core/plate_core.dart';

import 'dominica_colors.dart';

abstract final class DominicaThemes {
  static final PlateTheme regular = PlateTheme.monochrome(
    field: DominicaColors.black,
    ink: DominicaColors.silver,
    inactive: DominicaColors.inactive,
    borderWidthRatio: 0,
    plateRadiusRatio: 0,
  );
}
