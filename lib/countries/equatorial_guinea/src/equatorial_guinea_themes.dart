import 'package:license_plate/core/plate_core.dart';

import 'equatorial_guinea_colors.dart';

abstract final class EquatorialGuineaThemes {
  static final PlateTheme regular = PlateTheme.monochrome(
    field: EquatorialGuineaColors.white,
    ink: EquatorialGuineaColors.black,
    borderWidthRatio: 0.04,
    plateRadiusRatio: 0.09,
  );
}
