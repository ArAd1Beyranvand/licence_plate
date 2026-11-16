import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'gambia_colors.dart';

/// Black ink and frame on one field. Frame width depends on plate size, so
/// each spec sets its own `borderWidthRatioOverride`; the corner radius is
/// shared.
abstract final class GambiaThemes {
  static final PlateTheme private = _ink(GambiaColors.white);

  static final PlateTheme commercial = _ink(GambiaColors.yellow);
}

PlateTheme _ink(Color field) => PlateTheme.monochrome(
  field: field,
  ink: GambiaColors.black,
  borderWidthRatio: 0.036,
  plateRadiusRatio: 0.055,
);
