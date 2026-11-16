import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'united_kingdom_colors.dart';

/// One ink on one field, frame in the ink. The artwork draws a thin rounded
/// frame (~2.5% of the height); real plates are usually unframed.
abstract final class UnitedKingdomThemes {
  static const double _border = 0.025, _radius = 0.06;

  static PlateTheme _mono(Color field, Color ink, {required Color inactive}) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        inactive: inactive,
        borderWidthRatio: _border,
        plateRadiusRatio: _radius,
      );

  static final PlateTheme front = _mono(
    UnitedKingdomColors.white,
    UnitedKingdomColors.black,
    inactive: UnitedKingdomColors.inactiveOnLight,
  );

  /// Black on yellow: the rear plate, trailers, diplomatic marks.
  static final PlateTheme rear = _mono(
    UnitedKingdomColors.rearYellow,
    UnitedKingdomColors.black,
    inactive: UnitedKingdomColors.inactiveOnLight,
  );

  /// Silver on black: pre-1980 vehicles in the historic tax class.
  static final PlateTheme historic = _mono(
    UnitedKingdomColors.black,
    UnitedKingdomColors.silver,
    inactive: UnitedKingdomColors.inactiveOnDark,
  );

  static final PlateTheme armedForces = _mono(
    UnitedKingdomColors.black,
    UnitedKingdomColors.white,
    inactive: UnitedKingdomColors.inactiveOnDark,
  );

  static final PlateTheme trade = _mono(
    UnitedKingdomColors.white,
    UnitedKingdomColors.tradeRed,
    inactive: UnitedKingdomColors.inactiveOnLight,
  );
}
