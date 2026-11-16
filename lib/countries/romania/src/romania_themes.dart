import 'package:flutter/widgets.dart' show Color;
import 'package:license_plate/core/plate_core.dart';

import 'romania_colors.dart';

/// Framed plates (electric, test, local administration) print the rim in the
/// ink; the rest show none. Rim and corner are read by eye (`CALIBRATE`).
abstract final class RomaniaThemes {
  static const double _rim = 0.02;

  static PlateTheme _plate({
    required Color field,
    required Color ink,
    double border = 0,
  }) => PlateTheme.monochrome(
    field: field,
    ink: ink,
    borderWidthRatio: border,
    plateRadiusRatio: 0.05,
  );

  /// Black on white.
  static final PlateTheme standard = _plate(
    field: RomaniaColors.white,
    ink: RomaniaColors.black,
  );

  /// Green on white, framed.
  static final PlateTheme electric = _plate(
    field: RomaniaColors.white,
    ink: RomaniaColors.electricGreen,
    border: _rim,
  );

  /// Red on white: short-term temporary plates.
  static final PlateTheme temporary = _plate(
    field: RomaniaColors.white,
    ink: RomaniaColors.temporaryRed,
  );

  /// Red on white with a red rim: test vehicles.
  static final PlateTheme test = _plate(
    field: RomaniaColors.white,
    ink: RomaniaColors.testRed,
    border: _rim,
  );

  /// Blue on white: diplomatic (CD), consular transport (TC) and consulate
  /// (CO) plates.
  static final PlateTheme diplomatic = _plate(
    field: RomaniaColors.white,
    ink: RomaniaColors.diplomaticBlue,
  );

  /// Black on white, no Euroband: Ministry of Interior.
  static final PlateTheme ministryOfInterior = standard;

  /// Black on white, no Euroband: Armed Forces.
  static final PlateTheme army = standard;

  /// Black on yellow, framed.
  static final PlateTheme localAdministration = _plate(
    field: RomaniaColors.localYellow,
    ink: RomaniaColors.localInk,
    border: _rim,
  );
}
