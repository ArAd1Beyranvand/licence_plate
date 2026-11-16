import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'tristan_da_cunha_colors.dart';

abstract final class TristanDaCunhaThemes {
  static PlateTheme _theme(Color field, Color ink, Color inactive) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        inactive: inactive,
        borderWidthRatio: 0,
        plateRadiusRatio: 0.02,
      );

  static final PlateTheme standard = _theme(
    TristanDaCunhaColors.black,
    TristanDaCunhaColors.white,
    TristanDaCunhaColors.inactiveOnDark,
  );
  static final PlateTheme onWhite = _theme(
    TristanDaCunhaColors.white,
    TristanDaCunhaColors.black,
    TristanDaCunhaColors.inactiveOnLight,
  );
  static final PlateTheme onYellow = _theme(
    TristanDaCunhaColors.yellow,
    TristanDaCunhaColors.black,
    TristanDaCunhaColors.inactiveOnLight,
  );
}
