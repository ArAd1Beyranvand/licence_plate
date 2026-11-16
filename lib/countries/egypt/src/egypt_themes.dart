import 'package:license_plate/core/plate_core.dart';

import 'egypt_colors.dart';

/// Black on white in a thin frame for every plate; the category is the band,
/// which belongs to the country block, not the theme.
abstract final class EgyptThemes {
  static const PlateTheme standard = PlateTheme.monochrome(
    field: EgyptColors.field,
    ink: EgyptColors.ink,
    borderWidthRatio: 0.018,
    plateRadiusRatio: 0.055,
  );
}
