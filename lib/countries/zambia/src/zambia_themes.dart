import 'package:license_plate/core/plate_core.dart';

import 'zambia_colors.dart';

/// Red on white, the frame in the ink. Border and corner ratios are not
/// measured.
abstract final class ZambiaThemes {
  static final PlateTheme private = PlateTheme.monochrome(
    field: ZambiaColors.white,
    ink: ZambiaColors.red,
    borderWidthRatio: 0.03,
    plateRadiusRatio: 0.04,
  );
}
