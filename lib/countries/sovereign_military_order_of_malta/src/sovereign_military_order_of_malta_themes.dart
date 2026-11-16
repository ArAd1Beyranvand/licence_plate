import 'package:license_plate/core/plate_core.dart';

import 'sovereign_military_order_of_malta_colors.dart';

/// Black number on the off-white field. The prefix's red is the spec's: it is
/// printed in red whatever the livery. The photo shows no clear frame; the 2%
/// ink frame and 5% radius are estimates.
abstract final class SovereignMilitaryOrderOfMaltaThemes {
  static final PlateTheme standard = PlateTheme.monochrome(
    field: SovereignMilitaryOrderOfMaltaColors.field,
    ink: SovereignMilitaryOrderOfMaltaColors.black,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.05,
  );
}
