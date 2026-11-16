import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'lithuania_colors.dart';

/// One ink on one field, frame in the ink colour.
abstract final class LithuaniaThemes {
  static final PlateTheme private = _theme(
    LithuaniaColors.white,
    LithuaniaColors.black,
  );

  static final PlateTheme taxi = _theme(
    LithuaniaColors.taxiField,
    LithuaniaColors.taxiInk,
  );

  static final PlateTheme dealer = _theme(
    LithuaniaColors.white,
    LithuaniaColors.red,
  );

  static final PlateTheme temporary = dealer;

  static final PlateTheme military = _theme(
    LithuaniaColors.militaryField,
    LithuaniaColors.militaryInk,
  );

  static final PlateTheme agricultural = _theme(
    LithuaniaColors.white,
    LithuaniaColors.agriculturalInk,
  );

  static final PlateTheme diplomatic = _theme(
    LithuaniaColors.diplomaticField,
    LithuaniaColors.diplomaticInk,
  );
}

/// The frame is about 4 of the 110 units of height.
PlateTheme _theme(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.036,
  plateRadiusRatio: 0.08,
);
