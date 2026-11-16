import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'portugal_colors.dart';

/// One ink on one field, the frame in the ink.
///
/// The vector reference's frame is about 4.3 of 110 thick (0.04) with a corner
/// arc near 10 (0.09). The diplomatic photo shows only a faint rim, so it has
/// no frame; the 1937 plate's rim is not measured and borrows the 0.04.
abstract final class PortugalThemes {
  /// Every plate with the EU band.
  static final PlateTheme private = _framed(
    PortugalColors.white,
    PortugalColors.black,
  );

  /// Red on white, no frame.
  static final PlateTheme diplomatic = PlateTheme.monochrome(
    field: PortugalColors.white,
    ink: PortugalColors.diplomaticRed,
    borderWidthRatio: 0,
    plateRadiusRatio: 0.06,
  );

  /// White on black, the 1937–1992 series and tactical military plates.
  static final PlateTheme historic = _framed(
    PortugalColors.historicField,
    PortugalColors.historicInk,
  );
}

PlateTheme _framed(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.04,
  plateRadiusRatio: 0.09,
);
