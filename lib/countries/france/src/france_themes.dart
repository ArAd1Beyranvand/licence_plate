import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'france_colors.dart';

/// One ink on one field, framed in the ink. The frame is 2.5 of 110 thick
/// (0.0227); the two-line plate's 204-tall canvas takes the same 2.5. The
/// radius is estimated, not measured.
abstract final class FranceThemes {
  static final PlateTheme private = _framed(
    FranceColors.white,
    FranceColors.black,
    0.0227,
  );
  static final PlateTheme twoLine = _framed(
    FranceColors.white,
    FranceColors.black,
    0.0123,
  );

  /// Classic cars: white characters on black.
  static final PlateTheme collection = _framed(
    FranceColors.black,
    FranceColors.white,
    0.0227,
  );
  static final PlateTheme transit = _framed(
    FranceColors.transitRed,
    FranceColors.white,
    0.0227,
  );
  static final PlateTheme temporary = _framed(
    FranceColors.temporaryPink,
    FranceColors.temporaryInk,
    0.0227,
  );
  static final PlateTheme diplomatic = _framed(
    FranceColors.diplomaticGreen,
    FranceColors.diplomaticOrange,
    0.0227,
  );
}

PlateTheme _framed(Color field, Color ink, double border) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      borderWidthRatio: border,
      plateRadiusRatio: 0.055,
    );
