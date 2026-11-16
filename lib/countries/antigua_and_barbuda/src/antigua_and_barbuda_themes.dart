import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'antigua_and_barbuda_colors.dart';

/// One ink on one field each. Border 0.03 / radius 0.05 are estimates: the
/// graphic shows a heavy black frame, the photos only an embossed edge.
abstract final class AntiguaAndBarbudaThemes {
  static final PlateTheme private = _ink(
    AntiguaAndBarbudaColors.white,
    AntiguaAndBarbudaColors.black,
  );
  static final PlateTheme government = _ink(
    AntiguaAndBarbudaColors.gold,
    AntiguaAndBarbudaColors.navy,
  );
  static final PlateTheme taxi = _ink(
    AntiguaAndBarbudaColors.green,
    AntiguaAndBarbudaColors.cream,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.05,
);
