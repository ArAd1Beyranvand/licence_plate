import 'package:license_plate/core/plate_core.dart';

import 'democratic_republic_of_the_congo_colors.dart';

/// One ink on one field, framed in the ink. Frame 0.04 and corners 0.06 of
/// the height are read off the private artwork's outline; the other plates
/// reuse them, as no photograph shows a rim well enough to measure.
abstract final class DemocraticRepublicOfTheCongoThemes {
  static const PlateTheme _white = PlateTheme.monochrome(
    field: DemocraticRepublicOfTheCongoColors.white,
    ink: DemocraticRepublicOfTheCongoColors.black,
    borderWidthRatio: 0.04,
    plateRadiusRatio: 0.06,
  );

  static const PlateTheme private = _white;

  /// White on dark blue.
  static const PlateTheme organisation = PlateTheme.monochrome(
    field: DemocraticRepublicOfTheCongoColors.navy,
    ink: DemocraticRepublicOfTheCongoColors.paleWhite,
    inactive: DemocraticRepublicOfTheCongoColors.inactiveOnDark,
    borderWidthRatio: 0.04,
    plateRadiusRatio: 0.06,
  );

  /// Orange on dark blue.
  static const PlateTheme police = PlateTheme.monochrome(
    field: DemocraticRepublicOfTheCongoColors.navy,
    ink: DemocraticRepublicOfTheCongoColors.policeOrange,
    inactive: DemocraticRepublicOfTheCongoColors.inactiveOnDark,
    borderWidthRatio: 0.04,
    plateRadiusRatio: 0.06,
  );

  /// White on black.
  static const PlateTheme fardc = PlateTheme.monochrome(
    field: DemocraticRepublicOfTheCongoColors.armyField,
    ink: DemocraticRepublicOfTheCongoColors.armyInk,
    inactive: DemocraticRepublicOfTheCongoColors.inactiveOnDark,
    borderWidthRatio: 0.04,
    plateRadiusRatio: 0.06,
  );

  /// Dark on orange.
  static const PlateTheme diplomatic = PlateTheme.monochrome(
    field: DemocraticRepublicOfTheCongoColors.diplomaticField,
    ink: DemocraticRepublicOfTheCongoColors.diplomaticInk,
    inactive: DemocraticRepublicOfTheCongoColors.inactiveOnDark,
    borderWidthRatio: 0.04,
    plateRadiusRatio: 0.06,
  );

  /// Dark on pale grey, no rim.
  static const PlateTheme unitedNations = PlateTheme.monochrome(
    field: DemocraticRepublicOfTheCongoColors.unField,
    ink: DemocraticRepublicOfTheCongoColors.unInk,
    borderWidthRatio: 0.0,
    plateRadiusRatio: 0.04,
  );
}
