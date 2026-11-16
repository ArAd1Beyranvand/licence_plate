import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'samoa_colors.dart';

/// One ink on one field, the frame in the ink. Border and corner ratios are
/// read off the 2000 photo (frame about 3 of 134 units) and shared.
abstract final class SamoaThemes {
  /// 2000 plate, blue on white.
  static final PlateTheme modern = _ink(
    SamoaColors.whiteField,
    SamoaColors.blue,
  );

  /// Late-1950s plate, white on green.
  static final PlateTheme green = _ink(SamoaColors.green, SamoaColors.greenInk);

  /// 1979 plate, black on mint.
  static final PlateTheme mint = _ink(SamoaColors.mint, SamoaColors.black);

  /// 1979 government plate, maroon on teal.
  static final PlateTheme government = _ink(
    SamoaColors.teal,
    SamoaColors.maroon,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.022,
  plateRadiusRatio: 0.04,
);
