import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'el_salvador_colors.dart';

/// One ink on one field, the frame in the ink.
///
/// The frame is a thin embossed line about 0.03 of the height in the photos;
/// the ratio and the 0.05 corner radius are estimated, not measured.
abstract final class ElSalvadorThemes {
  static final PlateTheme private = _ink(
    ElSalvadorColors.tan,
    ElSalvadorColors.ink,
  );

  static final PlateTheme motorcycle = _ink(
    ElSalvadorColors.motorcycleTan,
    ElSalvadorColors.motorcycleInk,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.05,
);
