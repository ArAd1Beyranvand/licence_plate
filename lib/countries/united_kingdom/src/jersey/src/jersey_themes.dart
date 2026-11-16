import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'jersey_colors.dart';

/// One ink on one field, with a thin frame in the ink.
abstract final class JerseyThemes {
  static PlateTheme _mono(Color field, Color ink) => PlateTheme.monochrome(
    field: field,
    ink: ink,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.04,
  );

  static final PlateTheme front = _mono(
    JerseyColors.silver,
    JerseyColors.slate,
  );

  static final PlateTheme rear = _mono(
    JerseyColors.rearYellow,
    JerseyColors.rearInk,
  );
}
