import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ivory_coast_colors.dart';

/// One ink on one field with a white frame, and the colour of the strip at the
/// right (read through `PlateFill.divider`). The frame is ~4 of 110 units on
/// the photographs (estimated from the rounded edge, not measured).
abstract final class IvoryCoastThemes {
  /// White on blue, orange strip.
  static final PlateTheme private = _plate(
    IvoryCoastColors.blue,
    IvoryCoastColors.white,
    IvoryCoastColors.orange,
  );

  /// Black on orange, white strip.
  static final PlateTheme diplomatic = _plate(
    IvoryCoastColors.orange,
    IvoryCoastColors.black,
    IvoryCoastColors.white,
  );

  /// White on green, orange strip.
  static final PlateTheme temporary = _plate(
    IvoryCoastColors.green,
    IvoryCoastColors.white,
    IvoryCoastColors.orange,
  );

  /// White on black, no frame.
  static final PlateTheme military = PlateTheme.monochrome(
    field: IvoryCoastColors.black,
    ink: IvoryCoastColors.white,
    borderWidthRatio: 0,
    plateRadiusRatio: 0.06,
  );
}

PlateTheme _plate(Color field, Color ink, Color strip) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.04,
  plateRadiusRatio: 0.06,
).copyWith(plateBorder: IvoryCoastColors.white, dividerColor: strip);
