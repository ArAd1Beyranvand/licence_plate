import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'hungary_colors.dart';

/// One ink on one field with a frame in the ink's colour.
///
/// The 2022 plate's frame measures 5 of 110 units (0.045); the other flats are
/// too blurred to read a width, so they take a thinner 0.02. Corner arc 0.05
/// read off the flats.
abstract final class HungaryThemes {
  /// Black on white: the 2022 plate and the older-style plates.
  static final PlateTheme private = _theme(
    HungaryColors.white,
    HungaryColors.black,
    0.045,
  );

  static final PlateTheme oldStyle = _theme(
    HungaryColors.white,
    HungaryColors.black,
    0.02,
  );

  /// Diplomatic: pale blue on blue.
  static final PlateTheme diplomatic = _theme(
    HungaryColors.diplomaticField,
    HungaryColors.diplomaticInk,
    0.02,
  );

  /// Embassy staff: red on cream.
  static final PlateTheme staff = _theme(
    HungaryColors.staffField,
    HungaryColors.staffInk,
    0.02,
  );

  /// Slow vehicles: red on white.
  static final PlateTheme slowVehicle = _theme(
    HungaryColors.white,
    HungaryColors.slowInk,
    0.03,
  );
}

PlateTheme _theme(Color field, Color ink, double border) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      borderWidthRatio: border,
      plateRadiusRatio: 0.05,
    );
