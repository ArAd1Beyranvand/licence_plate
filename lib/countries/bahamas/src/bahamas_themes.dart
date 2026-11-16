import 'package:flutter/painting.dart' show Color;
import 'package:license_plate/core/plate_core.dart';

import 'bahamas_colors.dart';

/// One ink on one field, framed in the ink. [_field]'s `framed` plates show a
/// rim; the others a hairline.
abstract final class BahamasThemes {
  static PlateTheme _field({
    required Color field,
    required Color ink,
    required Color inactive,
    bool framed = true,
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

  /// Black on yellow, 1987–89.
  static final PlateTheme yellow = _field(
    field: BahamasColors.yellow,
    ink: BahamasColors.black,
    inactive: BahamasColors.inactiveOnLight,
    framed: false,
  );

  /// White on green, 1990–91.
  static final PlateTheme green = _field(
    field: BahamasColors.green,
    ink: BahamasColors.greenInk,
    inactive: BahamasColors.inactiveOnDark,
    framed: false,
  );

  /// Black on pale cyan, 1977.
  static final PlateTheme pale = _field(
    field: BahamasColors.pale,
    ink: BahamasColors.paleInk,
    inactive: BahamasColors.inactiveOnLight,
  );

  /// Blue on yellow, the 1992 First Landfall truck plate.
  static final PlateTheme landfall = _field(
    field: BahamasColors.landfallField,
    ink: BahamasColors.landfallInk,
    inactive: BahamasColors.inactiveOnLight,
  );

  /// Gold on blue, 1997–2015.
  static final PlateTheme blue = _field(
    field: BahamasColors.blue,
    ink: BahamasColors.gold,
    inactive: BahamasColors.inactiveOnDark,
    framed: false,
  );
}
