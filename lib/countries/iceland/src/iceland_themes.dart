import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'iceland_colors.dart';

/// One ink on one field, framed in the ink. The frame is 3 of 110, an
/// estimate: the flattened photographs do not resolve it.
abstract final class IcelandThemes {
  static PlateTheme _theme(Color field, Color ink, {required Color inactive}) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        inactive: inactive,
        borderWidthRatio: 0.03,
        plateRadiusRatio: 0.06,
      );

  static final PlateTheme standard = _theme(
    IcelandColors.white,
    IcelandColors.blue,
    inactive: IcelandColors.inactiveOnLight,
  );

  static final PlateTheme commercial = _theme(
    IcelandColors.white,
    IcelandColors.red,
    inactive: IcelandColors.inactiveOnLight,
  );

  static final PlateTheme diplomatic = _theme(
    IcelandColors.diplomaticGreen,
    IcelandColors.diplomaticInk,
    inactive: IcelandColors.inactiveOnDark,
  );

  static final PlateTheme oil = _theme(
    IcelandColors.oilYellow,
    IcelandColors.oilInk,
    inactive: IcelandColors.inactiveOnLight,
  );

  static final PlateTheme temporary = _theme(
    IcelandColors.dealerRed,
    IcelandColors.dealerInk,
    inactive: IcelandColors.inactiveOnDark,
  );

  static final PlateTheme offRoad = _theme(
    IcelandColors.offRoadRed,
    IcelandColors.offRoadInk,
    inactive: IcelandColors.inactiveOnDark,
  );

  static final PlateTheme moped = _theme(
    IcelandColors.mopedBlue,
    IcelandColors.mopedInk,
    inactive: IcelandColors.inactiveOnDark,
  );
}
