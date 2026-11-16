import 'package:license_plate/core/plate_core.dart';

import 'new_caledonia_colors.dart';

abstract final class NewCaledoniaThemes {
  static final PlateTheme private = PlateTheme.monochrome(
    field: NewCaledoniaColors.white,
    ink: NewCaledoniaColors.black,
    borderWidthRatio: 0.0227,
    plateRadiusRatio: 0.03,
  );
}
