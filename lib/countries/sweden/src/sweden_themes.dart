import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'sweden_colors.dart';

/// One ink on one field. Only the ordinary and taxi plates carry a thin
/// printed frame.
abstract final class SwedenThemes {
  static final PlateTheme private = _theme(
    SwedenColors.white,
    SwedenColors.black,
    border: 0.015,
  );

  static final PlateTheme taxi = _theme(
    SwedenColors.taxiYellow,
    SwedenColors.taxiInk,
    border: 0.015,
  );

  static final PlateTheme dealer = _theme(
    SwedenColors.dealerGreen,
    SwedenColors.dealerInk,
  );

  static final PlateTheme diplomatic = _theme(
    SwedenColors.diplomaticBlue,
    SwedenColors.diplomaticInk,
  );

  static final PlateTheme temporary = _theme(
    SwedenColors.temporaryRed,
    SwedenColors.temporaryInk,
  );

  static final PlateTheme military = _theme(
    SwedenColors.militaryBlack,
    SwedenColors.militaryInk,
  );
}

PlateTheme _theme(Color field, Color ink, {double border = 0}) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      borderWidthRatio: border,
      plateRadiusRatio: 0.06,
    );
