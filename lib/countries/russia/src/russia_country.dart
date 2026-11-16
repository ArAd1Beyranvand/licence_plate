import 'package:license_plate/core/plate_core.dart';

import 'russia_colors.dart';

/// No plate prints a country block: each spec draws `RUS` and the flag beside
/// the region field, so [flagDrawing] serves hosts that list countries.
abstract final class RussiaCountry {
  static const PlateDrawing flagDrawing = PlateDrawing(9, 6, <PlateShape>[
    PlateRectShape(0, 0, 9, 6, RussiaColors.white),
    PlateRectShape(0, 2, 9, 2, RussiaColors.flagBlue),
    PlateRectShape(0, 4, 9, 2, RussiaColors.flagRed),
  ]);

  static const PlateCountry russia = PlateCountry(
    code: 'ru',
    captionLines: <String>['RUS'],
    panelColor: RussiaColors.white,
    panelTextColor: RussiaColors.black,
    flagAspectRatio: 3 / 2,
    flag: flagDrawing,
  );
}
