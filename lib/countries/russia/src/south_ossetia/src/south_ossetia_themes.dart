import 'package:license_plate/core/plate_core.dart';

import 'south_ossetia_colors.dart';

abstract final class SouthOssetiaThemes {
  /// Black frame, ~3 mm on 110.
  static final PlateTheme standard = PlateTheme.monochrome(
    field: SouthOssetiaColors.white,
    ink: SouthOssetiaColors.black,
    borderWidthRatio: 0.03,
    plateRadiusRatio: 0.05,
  );
}
