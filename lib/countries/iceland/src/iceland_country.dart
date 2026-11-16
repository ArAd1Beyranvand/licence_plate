import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'iceland_colors.dart';

/// Iceland as a `PlateCountry`. The flag and `IS` sit on the white face, drawn
/// by the standard spec, so every spec sets `noPanel`; the flag here is for
/// hosts that list countries.
abstract final class IcelandCountry {
  static const PlateDrawing flagDrawing = PlateDrawing(25, 18, <PlateShape>[
    PlateRectShape(0, 0, 25, 18, IcelandColors.flagBlue),
    PlateRectShape(7, 0, 4, 18, Color(0xFFFFFFFF)),
    PlateRectShape(0, 7, 25, 4, Color(0xFFFFFFFF)),
    PlateRectShape(8, 0, 2, 18, IcelandColors.flagRed),
    PlateRectShape(0, 8, 25, 2, IcelandColors.flagRed),
  ]);

  static const PlateCountry iceland = PlateCountry(
    code: 'is',
    panelColor: IcelandColors.flagBlue,
    panelTextColor: Color(0xFFFFFFFF),
    flagAspectRatio: 25 / 18,
    flag: flagDrawing,
  );
}
