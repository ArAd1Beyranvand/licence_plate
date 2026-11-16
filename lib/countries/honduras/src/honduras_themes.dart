import 'package:license_plate/core/plate_core.dart';

import 'honduras_colors.dart';

/// Black on white with a black frame. The frame is about 0.02 of the height in
/// the photo and the 0.05 corner radius is estimated, not measured.
abstract final class HondurasThemes {
  static final PlateTheme private = PlateTheme.monochrome(
    field: HondurasColors.white,
    ink: HondurasColors.ink,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.05,
  );
}
