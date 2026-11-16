import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'georgia_country_colors.dart';

/// One ink on one field, framed in the ink: rim 2% of the height, corner arc 5%.
abstract final class GeorgiaCountryThemes {
  static PlateTheme _theme(Color field, Color ink, {Color? inactive}) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        inactive: inactive ?? GeorgiaCountryColors.inactiveOnLight,
        borderWidthRatio: 0.02,
        plateRadiusRatio: 0.05,
      );

  /// Black on white with the blue strip: private, trailer, squared, motorcycle,
  /// vanity.
  static final PlateTheme private = _theme(
    GeorgiaCountryColors.white,
    GeorgiaCountryColors.black,
  );

  static final PlateTheme temporary = _theme(
    GeorgiaCountryColors.white,
    GeorgiaCountryColors.temporaryRed,
  );

  static final PlateTheme export = _theme(
    GeorgiaCountryColors.white,
    GeorgiaCountryColors.black,
  );

  static final PlateTheme transit = _theme(
    GeorgiaCountryColors.white,
    GeorgiaCountryColors.black,
  );

  static final PlateTheme mission = _theme(
    GeorgiaCountryColors.missionField,
    GeorgiaCountryColors.missionInk,
    inactive: GeorgiaCountryColors.inactiveOnDark,
  );

  static final PlateTheme military = _theme(
    GeorgiaCountryColors.militaryField,
    GeorgiaCountryColors.militaryInk,
    inactive: GeorgiaCountryColors.inactiveOnDark,
  );

  static final PlateTheme diplomatic = _theme(
    GeorgiaCountryColors.diplomaticRed,
    GeorgiaCountryColors.white,
    inactive: GeorgiaCountryColors.inactiveOnDark,
  );
}
