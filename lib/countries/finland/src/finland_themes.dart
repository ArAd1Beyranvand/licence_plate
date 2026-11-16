import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'finland_colors.dart';

/// One ink on one field, frame in the ink colour.
abstract final class FinlandThemes {
  static final PlateTheme private = _theme(
    FinlandColors.white,
    FinlandColors.black,
  );

  static final PlateTheme diplomatic = _theme(
    FinlandColors.diplomaticBlue,
    FinlandColors.diplomaticInk,
  );

  static final PlateTheme aland = _theme(
    FinlandColors.alandField,
    FinlandColors.alandBlue,
  );
}

PlateTheme _theme(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.015,
  plateRadiusRatio: 0.08,
);
