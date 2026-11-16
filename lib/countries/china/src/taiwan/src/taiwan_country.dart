import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'taiwan_colors.dart';

abstract final class TaiwanCountry {
  /// Red field, blue canton, white sun (12 rays as a star polygon).
  static const PlateDrawing flagDrawing = PlateDrawing(3, 2, <PlateShape>[
    PlateRectShape(0, 0, 3, 2, TaiwanColors.flagRed),
    PlateRectShape(0, 0, 1.5, 1, TaiwanColors.flagBlue),
    PlateStarShape(
      0.75,
      0.5,
      0.36,
      Color(0xFFFFFFFF),
      points: 12,
      innerRatio: 0.5,
    ),
  ]);

  static const PlateCountry taiwan = PlateCountry(
    code: 'tw',
    captionLines: <String>['TW'],
    panelColor: TaiwanColors.white,
    panelTextColor: TaiwanColors.black,
    flagAspectRatio: 3 / 2,
    flag: flagDrawing,
  );
}
