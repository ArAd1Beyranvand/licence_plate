import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'bahamas_colors.dart';

/// No series prints a country block, so every spec sets `noPanel`; the flag is
/// carried for hosts that list countries.
abstract final class BahamasCountry {
  static const PlateDrawing _flag = PlateDrawing(6, 3, <PlateShape>[
    PlateRectShape(0, 0, 6, 3, BahamasColors.flagAqua),
    PlateRectShape(1, 1, 5, 1, BahamasColors.flagGold),
    PlatePolygonShape(<Offset>[
      Offset(0, 3),
      Offset(2.5981, 1.5),
      Offset(0, 0),
    ], BahamasColors.black),
  ]);

  static const PlateCountry bahamas = PlateCountry(
    code: 'bs',
    panelColor: BahamasColors.flagAqua,
    panelTextColor: BahamasColors.black,
    flagAspectRatio: 2 / 1,
    flag: _flag,
  );
}
