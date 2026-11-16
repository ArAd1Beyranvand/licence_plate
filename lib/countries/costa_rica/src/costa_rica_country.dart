import 'package:license_plate/core/plate_core.dart';

import 'costa_rica_colors.dart';

/// Costa Rica as a `PlateCountry`. No plate prints a country block — the flag
/// is a small decal at the top right and the name is a caption — so every spec
/// sets `noPanel` and this carries the flag for hosts that list countries.
abstract final class CostaRicaCountry {
  /// 10×6, stripes 1:1:2:1:1: blue, white, red, white, blue.
  static const PlateDrawing flagDrawing = PlateDrawing(10, 6, <PlateShape>[
    PlateRectShape(0, 0, 10, 6, CostaRicaColors.flagBlue),
    PlateRectShape(0, 1, 10, 4, CostaRicaColors.white),
    PlateRectShape(0, 2, 10, 2, CostaRicaColors.flagRed),
  ]);

  static const PlateCountry costaRica = PlateCountry(
    code: 'cr',
    panelColor: CostaRicaColors.flagBlue,
    panelTextColor: CostaRicaColors.white,
    flagAspectRatio: 5 / 3,
    flag: flagDrawing,
  );
}
