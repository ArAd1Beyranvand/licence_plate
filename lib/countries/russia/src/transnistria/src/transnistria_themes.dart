import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'transnistria_colors.dart';

abstract final class TransnistriaThemes {
  static PlateTheme _theme(Color field, Color ink) => PlateTheme.monochrome(
    field: field,
    ink: ink,
    borderWidthRatio: 0.036,
    plateRadiusRatio: 0.06,
  );

  static final PlateTheme standard = _theme(
    TransnistriaColors.white,
    TransnistriaColors.black,
  );

  static final PlateTheme interior = _theme(
    TransnistriaColors.interiorBlue,
    TransnistriaColors.black,
  );

  /// Blue ink in a black frame, the divider black.
  static final PlateTheme diplomatic = PlateTheme(
    plateBackground: TransnistriaColors.white,
    plateBorder: TransnistriaColors.black,
    ink: TransnistriaColors.diplomaticInk,
    dividerColor: TransnistriaColors.black,
    borderWidthRatio: 0.036,
    plateRadiusRatio: 0.06,
    activeColor: TransnistriaColors.diplomaticInk,
    inactiveColor: TransnistriaColors.inactiveOnLight,
    alertColor: const Color(0xFFD32F2F),
  );
}
