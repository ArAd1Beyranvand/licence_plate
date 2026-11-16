import 'package:license_plate/core/plate_core.dart';

import 'south_ossetia_colors.dart';

/// The flag is three stripes, so it is a `PlateDrawing`.
abstract final class SouthOssetiaCountry {
  static const PlateDrawing flagDrawing = PlateDrawing(3, 2, <PlateShape>[
    PlateRectShape(0, 0, 3, 2, SouthOssetiaColors.white),
    PlateRectShape(0, 0.667, 3, 0.667, SouthOssetiaColors.flagRed),
    PlateRectShape(0, 1.333, 3, 0.667, SouthOssetiaColors.flagYellow),
  ]);

  static const PlateCountry southOssetia = PlateCountry(
    code: 'so',
    captionLines: <String>['RSO'],
    panelColor: SouthOssetiaColors.white,
    panelTextColor: SouthOssetiaColors.black,
    flagAspectRatio: 3 / 2,
    flag: flagDrawing,
  );
}
