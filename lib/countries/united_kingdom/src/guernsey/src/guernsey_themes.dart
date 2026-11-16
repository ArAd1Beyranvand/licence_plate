import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'guernsey_colors.dart';

/// One ink on one field. Guernsey's plates have no frame; Alderney's has a
/// thin one.
abstract final class GuernseyThemes {
  static PlateTheme _mono(Color field, Color ink, {double border = 0}) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        borderWidthRatio: border,
        plateRadiusRatio: 0.04,
      );

  static final PlateTheme front = _mono(
    GuernseyColors.white,
    GuernseyColors.black,
  );

  static final PlateTheme rear = _mono(
    GuernseyColors.rearYellow,
    GuernseyColors.rearInk,
  );

  static final PlateTheme alderney = _mono(
    GuernseyColors.alderneyYellow,
    GuernseyColors.alderneyInk,
    border: 0.012,
  );
}
