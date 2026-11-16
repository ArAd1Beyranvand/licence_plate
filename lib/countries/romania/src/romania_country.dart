import 'package:license_plate/core/plate_core.dart';

import 'romania_colors.dart';

/// Every spec draws the Euroband itself, so `captionLines` is empty; [flag] is
/// the tricolour for hosts that list countries.
abstract final class RomaniaCountry {
  static const PlateDrawing _flag = PlateDrawing(3, 2, <PlateShape>[
    PlateRectShape(0, 0, 3, 2, RomaniaColors.flagBlue),
    PlateRectShape(1, 0, 2, 2, RomaniaColors.flagYellow),
    PlateRectShape(2, 0, 1, 2, RomaniaColors.flagRed),
  ]);

  static const PlateCountry romania = PlateCountry(
    code: 'ro',
    panelColor: RomaniaColors.euroBlue,
    panelTextColor: RomaniaColors.white,
    flagAspectRatio: 3 / 2,
    flag: _flag,
  );
}
