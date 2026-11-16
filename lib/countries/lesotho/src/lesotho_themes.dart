import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'lesotho_colors.dart';

/// Only the private theme exists. Border and radius ratios are estimates.
abstract final class LesothoThemes {
  static final PlateTheme private = _ink(
    LesothoColors.white,
    LesothoColors.blue,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.02,
  plateRadiusRatio: 0.04,
);
