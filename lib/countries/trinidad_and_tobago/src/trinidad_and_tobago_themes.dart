import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'trinidad_and_tobago_colors.dart';

abstract final class TrinidadAndTobagoThemes {
  static PlateTheme _plate(Color field, Color ink, Color inactive) =>
      PlateTheme(
        plateBackground: field,
        plateBorder: field,
        ink: ink,
        dividerColor: ink,
        borderWidthRatio: 0,
        plateRadiusRatio: 0.03,
        activeColor: ink,
        inactiveColor: inactive,
        alertColor: const Color(0xFFD32F2F),
      );

  /// White on black.
  static final PlateTheme private = _plate(
    TrinidadAndTobagoColors.black,
    TrinidadAndTobagoColors.white,
    TrinidadAndTobagoColors.inactiveOnDark,
  );

  /// Silver on blue-black.
  static final PlateTheme commercial = _plate(
    TrinidadAndTobagoColors.commercialField,
    TrinidadAndTobagoColors.silver,
    TrinidadAndTobagoColors.inactiveOnDark,
  );

  /// Black on white.
  static final PlateTheme square = _plate(
    TrinidadAndTobagoColors.squareField,
    TrinidadAndTobagoColors.squareInk,
    TrinidadAndTobagoColors.inactiveOnLight,
  );
}
