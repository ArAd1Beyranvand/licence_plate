import 'package:license_plate/core/plate_core.dart';

import 'ghana_colors.dart';

/// Ghana as a `PlateCountry`. The plates carry a small flag and `GH` on the
/// face and no country strip, so every spec sets `noPanel`.
abstract final class GhanaCountry {
  /// Red, gold and green stripes with a black star, 900×600.
  // https://commons.wikimedia.org/wiki/File:Flag_of_Ghana.svg
  static const PlateDrawing flag = PlateDrawing(900, 600, <PlateShape>[
    PlateRectShape(0, 0, 900, 600, GhanaColors.flagGreen),
    PlateRectShape(0, 0, 900, 400, GhanaColors.flagGold),
    PlateRectShape(0, 0, 900, 200, GhanaColors.flagRed),
    PlateStarShape(450, 300, 100, GhanaColors.flagStar),
  ]);

  static const PlateCountry ghana = PlateCountry(
    code: 'gh',
    captionLines: <String>['GH'],
    panelColor: GhanaColors.white,
    panelTextColor: GhanaColors.black,
    flagAspectRatio: 3 / 2,
    flag: flag,
  );
}
