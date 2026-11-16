import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'cape_verde_colors.dart';

/// One ink on one field. The black plates have a ~4.4-unit frame on 110 and
/// ~7-unit corners (military reference); the diplomatic frame is a thin
/// ~1.5-unit line.
abstract final class CapeVerdeThemes {
  static final PlateTheme regular = _ink(
    CapeVerdeColors.black,
    CapeVerdeColors.white,
    frame: 0.04,
    radius: 0.065,
  );

  static final PlateTheme freeFont = _ink(
    CapeVerdeColors.ochre,
    CapeVerdeColors.brown,
    frame: 0.03,
    radius: 0.05,
  );

  static final PlateTheme diplomatic = _ink(
    CapeVerdeColors.diplomaticWhite,
    CapeVerdeColors.crimson,
    frame: 0.015,
    radius: 0.02,
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
