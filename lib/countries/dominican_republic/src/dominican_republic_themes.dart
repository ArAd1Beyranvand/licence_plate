import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'dominican_republic_colors.dart';

/// One ink on one field, the rim in the ink, so one helper and five calls.
///
/// The photos show embossed pressed-metal rims rather than a painted border;
/// the ratios are the thinnest that still reads as a rim at 300 x 152 mm.
abstract final class DominicanRepublicThemes {
  static PlateTheme _livery({
    required Color field,
    required Color ink,
    double border = 0.02,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: border,
    plateRadiusRatio: 0.05,
    activeColor: ink,
    inactiveColor: DominicanRepublicColors.inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  static final PlateTheme private1990 = _livery(
    field: DominicanRepublicColors.cream,
    ink: DominicanRepublicColors.creamInk,
  );

  static final PlateTheme passenger1980 = _livery(
    field: DominicanRepublicColors.greyWhite,
    ink: DominicanRepublicColors.greyWhiteInk,
    border: 0.012,
  );

  static final PlateTheme private1994 = _livery(
    field: DominicanRepublicColors.red,
    ink: DominicanRepublicColors.redInk,
    border: 0.012,
  );

  static final PlateTheme passenger1986 = _livery(
    field: DominicanRepublicColors.turquoise,
    ink: DominicanRepublicColors.turquoiseInk,
  );

  static final PlateTheme exempt = _livery(
    field: DominicanRepublicColors.white,
    ink: DominicanRepublicColors.black,
  );
}
