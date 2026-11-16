import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'china_colors.dart';

/// The Chinese liveries: one ink on one field, with a rim in the ink (the
/// white rim of a blue plate, the black rim of a yellow one).
///
/// Rim width and corner radius are not measured: the references are cropped
/// photographs with the rim cut off at an unknown place.
abstract final class ChinaThemes {
  static PlateTheme _livery({
    required Color field,
    required Color ink,
    required Color inactive,
    Color? divider,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: ink,
    ink: ink,
    dividerColor: divider ?? ink,
    borderWidthRatio: 0.022,
    plateRadiusRatio: 0.06,
    activeColor: ink,
    inactiveColor: inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  /// White on blue: small vehicles.
  static final PlateTheme blue = _livery(
    field: ChinaColors.blue,
    ink: ChinaColors.white,
    inactive: ChinaColors.inactiveOnDark,
  );

  /// Black on yellow: large vehicles, driving-school cars.
  static final PlateTheme yellow = _livery(
    field: ChinaColors.yellow,
    ink: ChinaColors.yellowInk,
    inactive: ChinaColors.inactiveOnLight,
  );

  /// White on black: Hong Kong / Macau cross-border vehicles.
  static final PlateTheme black = _livery(
    field: ChinaColors.black,
    ink: ChinaColors.blackInk,
    inactive: ChinaColors.inactiveOnDark,
  );

  /// Black on green: small New Energy.
  static final PlateTheme newEnergySmall = _livery(
    field: ChinaColors.newEnergySmall,
    ink: ChinaColors.newEnergyInk,
    inactive: ChinaColors.inactiveOnLight,
  );

  /// Black on green with a yellow province end: large New Energy. The yellow
  /// is the *divider* colour so `ChinaPlates.newEnergyLarge` can paint its
  /// end strip with `PlateFill.divider` and stay colour-free.
  static final PlateTheme newEnergyLarge = _livery(
    field: ChinaColors.newEnergyLarge,
    ink: ChinaColors.newEnergyInk,
    inactive: ChinaColors.inactiveOnLight,
    divider: ChinaColors.newEnergyYellow,
  );

  /// White on black: diplomatic.
  static final PlateTheme diplomatic = _livery(
    field: ChinaColors.black,
    ink: ChinaColors.diplomaticInk,
    inactive: ChinaColors.inactiveOnDark,
  );
}
