import 'package:license_plate/core/plate_core.dart';

import 'grenada_colors.dart';

/// Black on yellow, no printed frame (the 2010 artwork has none).
abstract final class GrenadaThemes {
  static final PlateTheme current = PlateTheme.monochrome(
    field: GrenadaColors.yellow,
    ink: GrenadaColors.black,
    borderWidthRatio: 0,
    plateRadiusRatio: 0.06,
  );
}
