import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'fiji_colors.dart';

/// One ink on one field, the frame in the ink. The pressed border is not
/// visible in the flattened photos; the ratios are not measured.
abstract final class FijiThemes {
  /// General issue (2012 dies), black on reflective white.
  static final PlateTheme general = _ink(FijiColors.white, FijiColors.ink);

  /// Older single-letter plates, on a yellowed field.
  static final PlateTheme legacy = _ink(FijiColors.aged, FijiColors.agedInk);

  static final PlateTheme motorcycle = _ink(
    FijiColors.motorcycle,
    FijiColors.motorcycleInk,
  );

  /// White on blue.
  static final PlateTheme government = _ink(
    FijiColors.government,
    FijiColors.governmentInk,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.05,
);
