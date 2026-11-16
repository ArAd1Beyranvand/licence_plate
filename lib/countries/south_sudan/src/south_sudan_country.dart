import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'south_sudan_colors.dart';

/// South Sudan as a `PlateCountry`. The flag is printed on the face as a
/// decal, so every spec sets `noPanel`.
abstract final class SouthSudanCountry {
  /// Flag_of_South_Sudan.svg (Commons), 1140×570: black, red and green
  /// stripes 170 tall separated by 30 of white, a blue triangle to x 493.6
  /// and a five-pointed star of radius 95 at (164.5, 285).
  static const PlateDrawing flagDrawing = PlateDrawing(1140, 570, <PlateShape>[
    PlateRectShape(0, 0, 1140, 570, SouthSudanColors.white),
    PlateRectShape(0, 0, 1140, 170, SouthSudanColors.flagBlack),
    PlateRectShape(0, 200, 1140, 170, SouthSudanColors.flagRed),
    PlateRectShape(0, 400, 1140, 170, SouthSudanColors.flagGreen),
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(493.634, 285),
      Offset(0, 570),
    ], SouthSudanColors.flagBlue),
    PlateStarShape(164.545, 285, 95, SouthSudanColors.flagYellow),
  ]);

  static const PlateCountry south_sudan = PlateCountry(
    code: 'ss',
    panelColor: SouthSudanColors.white,
    panelTextColor: SouthSudanColors.ink,
    flagAspectRatio: 2,
    flag: flagDrawing,
  );
}
