import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'czech_republic_colors.dart';

/// One ink on one field, framed in the ink's colour.
///
/// The current plate has a thick black frame (about 8 px of the 210 px
/// artwork, 0.035 of the height) and a 0.07 corner; the older photographed
/// plates a thin frame (0.02) read off the flats at about that precision.
abstract final class CzechRepublicThemes {
  /// Black on white: the current plate and the US-size, motorcycle and
  /// personalised plates.
  static final PlateTheme private = _theme(
    CzechRepublicColors.white,
    CzechRepublicColors.black,
    0.035,
    0.07,
  );

  /// 2001–2004: black on a grey-white field, no band, no frame.
  static final PlateTheme plain2001 = _theme(
    CzechRepublicColors.plain2001Field,
    CzechRepublicColors.plain2001Ink,
  );

  /// 1992–2001: dark grey on a grey-white field.
  static final PlateTheme classic = _theme(
    CzechRepublicColors.classicField,
    CzechRepublicColors.classicInk,
  );

  /// Czechoslovak 1970s plate, still valid.
  static final PlateTheme classic70s = _theme(
    CzechRepublicColors.classic70sField,
    CzechRepublicColors.classic70sInk,
  );

  /// Commercial vehicles: dark on yellow.
  static final PlateTheme commercial = _theme(
    CzechRepublicColors.commercialField,
    CzechRepublicColors.commercialInk,
  );

  static final PlateTheme military = _theme(
    CzechRepublicColors.militaryField,
    CzechRepublicColors.militaryInk,
  );

  static final PlateTheme export = _theme(
    CzechRepublicColors.exportField,
    CzechRepublicColors.exportInk,
  );

  /// Since 2001: blue letters on white.
  static final PlateTheme diplomatic = _theme(
    CzechRepublicColors.diplomaticField,
    CzechRepublicColors.diplomaticInk,
  );

  /// Historic vehicles: green on white.
  static final PlateTheme veteran = _theme(
    CzechRepublicColors.veteranField,
    CzechRepublicColors.veteranInk,
  );
}

PlateTheme _theme(
  Color field,
  Color ink, [
  double border = 0.02,
  double radius = 0.05,
]) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: border,
  plateRadiusRatio: radius,
);
