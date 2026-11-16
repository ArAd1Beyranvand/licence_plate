import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'hong_kong_colors.dart';

abstract final class HongKongThemes {
  static PlateTheme _theme(Color field, Color ink, Color inactive) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        inactive: inactive,
        borderWidthRatio: 0.03,
        plateRadiusRatio: 0.06,
      );

  static final PlateTheme private = _theme(
    HongKongColors.white,
    HongKongColors.black,
    HongKongColors.inactiveOnLight,
  );
  static final PlateTheme rear = _theme(
    HongKongColors.yellow,
    HongKongColors.black,
    HongKongColors.inactiveOnLight,
  );
  static final PlateTheme crossBorder = _theme(
    HongKongColors.crossBorderField,
    HongKongColors.white,
    HongKongColors.inactiveOnDark,
  );
}
