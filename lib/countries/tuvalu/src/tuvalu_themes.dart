import 'package:license_plate/core/plate_core.dart';

import 'tuvalu_colors.dart';

/// White on black with a white frame line. The frame is ~4 of 134 units in the
/// graphic (x 3–7 of 500), so 0.03.
abstract final class TuvaluThemes {
  static final PlateTheme standard = PlateTheme.monochrome(
    field: TuvaluColors.field,
    ink: TuvaluColors.ink,
    inactive: TuvaluColors.inactive,
    borderWidthRatio: 0.03,
    plateRadiusRatio: 0.05,
  );
}
