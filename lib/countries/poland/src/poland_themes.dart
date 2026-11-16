import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'poland_colors.dart';

/// One ink on one field, frame in the ink colour. Plates that differ from
/// [private] only in their format share its theme.
abstract final class PolandThemes {
  static final PlateTheme private = _theme(
    PolandColors.white,
    PolandColors.black,
  );

  static final PlateTheme custom = private, motorcycle = private;
  static final PlateTheme reduced = private, police = private;
  static final PlateTheme borderGuard = private, military = private;

  static final PlateTheme electric = _theme(
    PolandColors.electricField,
    PolandColors.black,
  );

  static final PlateTheme temporary = _theme(
    PolandColors.white,
    PolandColors.red,
  );

  static final PlateTheme test = temporary;

  static final PlateTheme professional = _theme(
    PolandColors.white,
    PolandColors.green,
  );

  static final PlateTheme classic = _theme(
    PolandColors.classicField,
    PolandColors.classicInk,
  );

  /// No frame is printed on the diplomatic plate.
  static final PlateTheme diplomatic = _theme(
    PolandColors.diplomaticField,
    PolandColors.diplomaticInk,
    border: 0,
  );
}

/// The frame is about 3.5 of the 110 units of height (the blue block starts
/// that far in); the corner radius is read off the large reference.
PlateTheme _theme(Color field, Color ink, {double border = 0.032}) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      borderWidthRatio: border,
      plateRadiusRatio: 0.05,
    );
