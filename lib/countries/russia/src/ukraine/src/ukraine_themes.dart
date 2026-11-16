import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ukraine_colors.dart';

/// One ink on one field, the frame in the ink. A rim of 4 mm on a 110 mm
/// plate is 0.036; corners ~0.05.
abstract final class UkraineThemes {
  static PlateTheme _theme(
    Color field,
    Color ink,
    Color inactive, {
    Color? rim,
    Color alert = const Color(0xFFD32F2F),
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: rim ?? ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: 0.036,
    plateRadiusRatio: 0.05,
    activeColor: ink,
    inactiveColor: inactive,
    alertColor: alert,
  );

  static final PlateTheme private = _theme(
    UkraineColors.white,
    UkraineColors.black,
    UkraineColors.inactiveOnLight,
  );

  static final PlateTheme transport = _theme(
    UkraineColors.transportYellow,
    UkraineColors.black,
    UkraineColors.inactiveOnLight,
  );

  static final PlateTheme legacyYellow = _theme(
    UkraineColors.legacyYellow,
    UkraineColors.black,
    UkraineColors.inactiveOnLight,
  );

  /// Temporary and 1997 diplomatic plates. The alert is near-black: the
  /// default red would vanish on the field.
  static final PlateTheme red = _theme(
    UkraineColors.red,
    UkraineColors.white,
    UkraineColors.inactiveOnDark,
    alert: const Color(0xFF1A1A1A),
  );

  static final PlateTheme police = _theme(
    UkraineColors.policeBlue,
    UkraineColors.white,
    UkraineColors.inactiveOnDark,
  );

  static final PlateTheme military = _theme(
    UkraineColors.militaryBlack,
    UkraineColors.white,
    UkraineColors.inactiveOnDark,
  );

  static final PlateTheme volunteers = _theme(
    UkraineColors.volunteerGreen,
    UkraineColors.white,
    UkraineColors.inactiveOnDark,
  );

  /// Motorcycle plates print no rim in the references.
  static final PlateTheme motorcycle = PlateTheme(
    plateBackground: UkraineColors.white,
    plateBorder: UkraineColors.black,
    ink: UkraineColors.black,
    dividerColor: UkraineColors.black,
    borderWidthRatio: 0,
    plateRadiusRatio: 0.05,
    activeColor: UkraineColors.black,
    inactiveColor: UkraineColors.inactiveOnLight,
    alertColor: const Color(0xFFD32F2F),
  );

  static final PlateTheme militaryMotorcycle = _theme(
    UkraineColors.militaryBlack,
    UkraineColors.white,
    UkraineColors.inactiveOnDark,
  );
}
