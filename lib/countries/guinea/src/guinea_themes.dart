import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'guinea_colors.dart';

/// One ink on one field, the frame in the ink colour. The ratios are of the
/// canvas height, so each canvas shape has its own: the frame measures ~4
/// units and the corners ~10 (one row, 110 high) or ~14 (two rows, ~280).
abstract final class GuineaThemes {
  static final PlateTheme standard = _ink(
    GuineaColors.white,
    GuineaColors.blue,
    0.036,
    0.09,
  );

  static final PlateTheme standardSquare = _ink(
    GuineaColors.white,
    GuineaColors.blue,
    0.016,
    0.05,
  );

  static final PlateTheme motorcycle = _ink(
    GuineaColors.white,
    GuineaColors.blue,
    0.015,
    0.05,
  );

  static final PlateTheme legacy = _ink(
    GuineaColors.red,
    GuineaColors.redInk,
    0.036,
    0.09,
  );

  static final PlateTheme legacySquare = _ink(
    GuineaColors.red,
    GuineaColors.redInk,
    0.016,
    0.05,
  );

  static final PlateTheme taxi = _ink(
    GuineaColors.black,
    GuineaColors.blackInk,
    0.036,
    0.09,
  );

  static final PlateTheme taxiSquare = _ink(
    GuineaColors.black,
    GuineaColors.blackInk,
    0.016,
    0.05,
  );
}

PlateTheme _ink(Color field, Color ink, double border, double radius) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      borderWidthRatio: border,
      plateRadiusRatio: radius,
    );
