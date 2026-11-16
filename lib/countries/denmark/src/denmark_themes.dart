import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'denmark_colors.dart';

/// One ink on one field with a frame of its own colour. The frame is ~4.5 mm
/// of the 110 mm height; the diplomatic and Faroese plates have none.
abstract final class DenmarkThemes {
  static PlateTheme _theme({
    required Color field,
    required Color ink,
    required Color frame,
    double border = 0.04,
    bool dark = false,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: frame,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: border,
    plateRadiusRatio: 0.07,
    activeColor: ink,
    inactiveColor: dark
        ? DenmarkColors.inactiveOnDark
        : DenmarkColors.inactiveOnLight,
    alertColor: const Color(0xFFD32F2F),
  );

  /// Black on white in a red frame: private, vanity and export plates.
  static final PlateTheme private = _theme(
    field: DenmarkColors.white,
    ink: DenmarkColors.black,
    frame: DenmarkColors.red,
  );

  /// Parrot plates: the same white field, but a black frame.
  static final PlateTheme parrot = _theme(
    field: DenmarkColors.white,
    ink: DenmarkColors.black,
    frame: DenmarkColors.black,
  );

  static final PlateTheme commercial = _theme(
    field: DenmarkColors.vanYellow,
    ink: DenmarkColors.black,
    frame: DenmarkColors.black,
  );

  static final PlateTheme diplomatic = _theme(
    field: DenmarkColors.diplomaticBlue,
    ink: DenmarkColors.white,
    frame: DenmarkColors.diplomaticBlue,
    border: 0,
    dark: true,
  );

  static final PlateTheme fixedTemporary = _theme(
    field: DenmarkColors.white,
    ink: DenmarkColors.red,
    frame: DenmarkColors.red,
  );

  static final PlateTheme greenland = _theme(
    field: DenmarkColors.greenlandField,
    ink: DenmarkColors.greenlandInk,
    frame: DenmarkColors.red,
  );

  static final PlateTheme faroeIslands = _theme(
    field: DenmarkColors.faroeField,
    ink: DenmarkColors.faroeInk,
    frame: DenmarkColors.faroeField,
    border: 0,
  );
}
