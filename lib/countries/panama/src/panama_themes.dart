import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'panama_colors.dart';

/// One ink on one field, the frame in the ink. The frame is not measured: the
/// 2016 and 2008 photos show none, so it is a thin 0.02 of the height.
abstract final class PanamaThemes {
  /// 2016 car.
  static final PlateTheme car = _ink(PanamaColors.white, PanamaColors.black);

  /// 2018 motorcycle.
  static final PlateTheme motorcycle = _ink(
    PanamaColors.motoWhite,
    PanamaColors.motoBlack,
  );

  /// 2007–2008 car on a cream field.
  static final PlateTheme cream = _ink(
    PanamaColors.cream,
    PanamaColors.creamInk,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.02,
  plateRadiusRatio: 0.04,
);
