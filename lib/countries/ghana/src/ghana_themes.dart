import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ghana_colors.dart';

/// One ink on one field, the frame in the ink colour. The two-row commercial
/// plate prints no frame.
abstract final class GhanaThemes {
  static final PlateTheme private = _ink(
    GhanaColors.white,
    GhanaColors.black,
    frame: 0.02,
    radius: 0.04,
  );

  /// Two-row commercial plate.
  static final PlateTheme commercial = _ink(
    GhanaColors.yellow,
    GhanaColors.black,
    frame: 0,
    radius: 0.03,
  );

  static final PlateTheme commercialOneRow = _ink(
    GhanaColors.yellow,
    GhanaColors.black,
    frame: 0.035,
    radius: 0.06,
  );

  static final PlateTheme motorcycle = _ink(
    GhanaColors.blue,
    GhanaColors.ink,
    frame: 0.02,
    radius: 0.05,
  );
}

PlateTheme _ink(
  Color field,
  Color ink, {
  required double frame,
  required double radius,
}) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: frame,
  plateRadiusRatio: radius,
);
