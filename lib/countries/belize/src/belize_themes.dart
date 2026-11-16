import 'package:flutter/painting.dart' show Color;
import 'package:license_plate/core/plate_core.dart';

import 'belize_colors.dart';

/// One ink on one field, framed in the ink. Only the twin-town plate shows a
/// rim in its photograph ([framed]); the others are a hairline.
abstract final class BelizeThemes {
  static PlateTheme _field({
    required Color field,
    required Color ink,
    required Color inactive,
    bool framed = false,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: framed ? 0.03 : 0.012,
    plateRadiusRatio: 0.07,
    activeColor: ink,
    inactiveColor: inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  static final PlateTheme standard = _field(
    field: BelizeColors.white,
    ink: BelizeColors.black,
    inactive: BelizeColors.inactiveOnLight,
  );

  /// Black on white with the rim of the 2009 twin-town plate.
  static final PlateTheme twin = _field(
    field: BelizeColors.white,
    ink: BelizeColors.black,
    inactive: BelizeColors.inactiveOnLight,
    framed: true,
  );

  static final PlateTheme dealer = _field(
    field: BelizeColors.dealerField,
    ink: BelizeColors.dealerInk,
    inactive: BelizeColors.inactiveOnLight,
  );

  static final PlateTheme truck = _field(
    field: BelizeColors.truckField,
    ink: BelizeColors.truckInk,
    inactive: BelizeColors.inactiveOnDark,
  );

  static final PlateTheme defence = _field(
    field: BelizeColors.defenceField,
    ink: BelizeColors.defenceInk,
    inactive: BelizeColors.inactiveOnDark,
  );

  static final PlateTheme taxi = _field(
    field: BelizeColors.taxiField,
    ink: BelizeColors.taxiInk,
    inactive: BelizeColors.inactiveOnDark,
  );
}
