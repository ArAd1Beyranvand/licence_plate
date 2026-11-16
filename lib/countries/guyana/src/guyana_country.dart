import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'guyana_colors.dart';

/// Guyana as a `PlateCountry`. No Guyanese plate prints a flag or a country
/// block, so every spec sets `noPanel`; this carries only the flag for hosts
/// that list countries.
///
/// The flag (the Golden Arrowhead) is stripes and triangles, so it is drawn in
/// code on a 5:3 field. Apexes are from the proportions on the Commons
/// construction sheet, not sampled from pixels.
abstract final class GuyanaCountry {
  static const PlateDrawing _flag = PlateDrawing(900, 540, <PlateShape>[
    PlateRectShape(0, 0, 900, 540, GuyanaColors.flagGreen),
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(900, 270),
      Offset(0, 540),
    ], GuyanaColors.white),
    PlatePolygonShape(<Offset>[
      Offset(0, 22),
      Offset(843, 270),
      Offset(0, 518),
    ], GuyanaColors.flagYellow),
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(405, 270),
      Offset(0, 540),
    ], GuyanaColors.black),
    PlatePolygonShape(<Offset>[
      Offset(0, 26),
      Offset(360, 270),
      Offset(0, 514),
    ], GuyanaColors.flagRed),
  ]);

  static const PlateCountry guyana = PlateCountry(
    code: 'gy',
    panelColor: GuyanaColors.flagGreen,
    panelTextColor: GuyanaColors.white,
    flagAspectRatio: 5 / 3,
    flag: _flag,
  );
}
