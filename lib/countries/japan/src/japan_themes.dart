import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'japan_colors.dart';

/// One ink on one field. The car plates have no printed frame (the artwork's
/// outline is a hairline); the two-wheelers carry a border of about 9.5 of
/// the 179 height in the lettering colour, white on the green plate.
abstract final class JapanThemes {
  static final PlateTheme private = _theme(
    JapanColors.white,
    JapanColors.green,
  );

  static final PlateTheme commercial = _theme(
    JapanColors.green,
    JapanColors.white,
  );

  static final PlateTheme keiPrivate = _theme(
    JapanColors.yellow,
    JapanColors.black,
  );

  static final PlateTheme keiCommercial = _theme(
    JapanColors.black,
    JapanColors.yellow,
  );

  static final PlateTheme motorcycle = _theme(
    JapanColors.white,
    JapanColors.bikeGreen,
    border: 0.05,
    radius: 0.04,
  );

  static final PlateTheme motorcycleCommercial = _theme(
    JapanColors.bikeGreen,
    JapanColors.bikeWhite,
    border: 0.05,
    radius: 0.04,
  );

  static final PlateTheme diplomatic = _theme(
    JapanColors.diplomaticField,
    JapanColors.diplomaticInk,
    radius: 0.04,
  );

  static final PlateTheme export = _theme(
    JapanColors.exportField,
    JapanColors.exportInk,
    radius: 0.04,
  );
}

PlateTheme _theme(
  Color field,
  Color ink, {
  double border = 0,
  double radius = 0.05,
}) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: border,
  plateRadiusRatio: radius,
);
