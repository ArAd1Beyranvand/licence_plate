import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'northern_cyprus_colors.dart';

abstract final class NorthernCyprusThemes {
  static PlateTheme _theme(
    Color field,
    Color ink,
    Color frame,
    Color inactive,
  ) => PlateTheme(
    plateBackground: field,
    plateBorder: frame,
    ink: ink,
    dividerColor: frame,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.05,
    activeColor: ink,
    inactiveColor: inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  static const Color _black = NorthernCyprusColors.black;
  static const Color _red = NorthernCyprusColors.red;
  static const Color _light = NorthernCyprusColors.inactiveOnLight;

  static final PlateTheme private = _theme(
    NorthernCyprusColors.white,
    _black,
    _black,
    _light,
  );
  static final PlateTheme rental = _theme(
    NorthernCyprusColors.rentalRed,
    _black,
    _black,
    _light,
  );
  static final PlateTheme government = _theme(
    NorthernCyprusColors.white,
    _black,
    _red,
    _light,
  );
  static final PlateTheme police = _theme(
    _black,
    NorthernCyprusColors.white,
    _red,
    NorthernCyprusColors.inactiveOnDark,
  );
  static final PlateTheme visitor = _theme(
    NorthernCyprusColors.white,
    _red,
    _red,
    _light,
  );
  static final PlateTheme diplomatic = _theme(
    NorthernCyprusColors.diplomaticTeal,
    _black,
    _black,
    _light,
  );
}
