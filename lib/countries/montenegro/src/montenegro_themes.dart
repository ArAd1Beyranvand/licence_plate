import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'montenegro_colors.dart';

/// One ink on one field with a frame in the ink's colour. The diplomatic plate
/// is yellow on white for the diplomat, mission and consular series, and
/// [press] is black on white for the press and economy series.
///
/// The frame is about 0.03 of the plate height and the corner arc about 0.07;
/// neither is measured more closely than that.
abstract final class MontenegroThemes {
  static final PlateTheme regular = _theme(
    MontenegroColors.white,
    MontenegroColors.black,
  );
  static final PlateTheme temporary = _theme(
    MontenegroColors.white,
    MontenegroColors.black,
  );
  static final PlateTheme diplomatic = _theme(
    MontenegroColors.white,
    MontenegroColors.diplomaticYellow,
  );
  static final PlateTheme press = _theme(
    MontenegroColors.white,
    MontenegroColors.black,
  );
  static final PlateTheme agricultural = _theme(
    MontenegroColors.agriculturalField,
    MontenegroColors.agriculturalInk,
  );
  static final PlateTheme moped = _theme(
    MontenegroColors.white,
    MontenegroColors.black,
  );
}

PlateTheme _theme(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.07,
).copyWith(plateBorder: ink);
