import 'package:license_plate/core/plate_core.dart';

import 'poland_colors.dart';

/// The blue block at the left of every plate but the diplomatic one.
abstract final class PolandCountry {
  /// Since 1 May 2006: the EU stars over `PL`.
  static const PlateCountry poland = PlateCountry(
    code: 'pl',
    captionLines: <String>['PL'],
    panelColor: PolandColors.panelBlue,
    panelTextColor: PolandColors.panelInk,
    flagAspectRatio: 3 / 2,
    flag: EuropeanStars.flag,
  );

  /// 2000–2006 plates, still printed for police, border guard and military:
  /// the national flag over `PL`.
  static const PlateCountry polandFlag = PlateCountry(
    code: 'pl',
    captionLines: <String>['PL'],
    panelColor: PolandColors.panelBlue,
    panelTextColor: PolandColors.panelInk,
    flagAspectRatio: 8 / 5,
    flag: PlateDrawing(8, 5, <PlateShape>[
      PlateRectShape(0, 0, 8, 2.5, PolandColors.white),
      PlateRectShape(0, 2.5, 8, 2.5, PolandColors.flagRed),
    ]),
  );
}
