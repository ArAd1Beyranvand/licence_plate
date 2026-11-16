import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'trinidad_and_tobago_colors.dart';

/// The plates print no country block, so every spec sets `noPanel`; the flag
/// is carried for hosts that list countries. 900×540 (30×18 artwork ×30): a red
/// field crossed from the upper hoist to the lower fly by a black band edged in
/// white.
abstract final class TrinidadAndTobagoCountry {
  static const PlateDrawing _flag = PlateDrawing(900, 540, <PlateShape>[
    PlateRectShape(0, 0, 900, 540, TrinidadAndTobagoColors.flagRed),
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(624.74, 540),
      Offset(900, 540),
      Offset(275.26, 0),
    ], TrinidadAndTobagoColors.flagWhite),
    PlatePolygonShape(<Offset>[
      Offset(45.88, 0),
      Offset(670.62, 540),
      Offset(854.12, 540),
      Offset(229.38, 0),
    ], TrinidadAndTobagoColors.flagBlack),
  ]);

  static const PlateCountry trinidad_and_tobago = PlateCountry(
    code: 'tt',
    panelColor: TrinidadAndTobagoColors.flagRed,
    panelTextColor: TrinidadAndTobagoColors.flagWhite,
    flagAspectRatio: 5 / 3,
    flag: _flag,
  );
}
