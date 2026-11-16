import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'nauru_colors.dart';

/// One ink on one field, the frame in the ink.
///
/// The photos show a raised rim rather than a printed line, so the border is a
/// thin 0.02 of the height and the corners round at 0.04; neither is measured.
abstract final class NauruThemes {
  /// 2015– plate: black on white.
  static final PlateTheme current = _ink(NauruColors.field, NauruColors.ink);

  /// 1975–2015 plate: black on white.
  static final PlateTheme legacy = _ink(
    NauruColors.legacyField,
    NauruColors.legacyInk,
  );

  /// 1970–75 plate: white on black.
  static final PlateTheme classic = _ink(
    NauruColors.classicField,
    NauruColors.classicInk,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.02,
  plateRadiusRatio: 0.04,
);
