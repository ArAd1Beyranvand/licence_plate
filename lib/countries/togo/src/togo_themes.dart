import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'togo_colors.dart';

/// One ink on one field, the frame in the ink colour.
abstract final class TogoThemes {
  /// Blue on white.
  static final PlateTheme regular = _ink(TogoColors.white, TogoColors.blue);

  /// Red on yellow.
  static final PlateTheme commercial = _ink(TogoColors.yellow, TogoColors.red);
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.09,
);
