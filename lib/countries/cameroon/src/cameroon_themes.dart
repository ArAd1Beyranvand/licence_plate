import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'cameroon_colors.dart';

/// One ink on one field. Frame (3.6 thick, 0.033) and corner (~10, 0.09)
/// ratios are measured on the 520 × 110 flat of `____1`; the diplomatic plate
/// reuses them.
abstract final class CameroonThemes {
  static final PlateTheme private = _ink(
    CameroonColors.orange,
    CameroonColors.black,
  );

  static final PlateTheme diplomatic = _ink(
    CameroonColors.diplomaticGreen,
    CameroonColors.white,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.033,
  plateRadiusRatio: 0.09,
);
