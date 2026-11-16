import 'package:license_plate/core/plate_core.dart';

import 'monaco_colors.dart';

/// Monaco as a `PlateCountry`. No plate prints a country block (the badge is a
/// decal on the face), so every spec sets `noPanel`; this carries the flag for
/// hosts that list countries. The flag, `Flag_of_Monaco.svg` (1000×800), is two
/// stripes, so it is drawn rather than shipped.
abstract final class MonacoCountry {
  static const PlateDrawing _flag = PlateDrawing(1000, 800, <PlateShape>[
    PlateRectShape(0, 0, 1000, 800, MonacoColors.white),
    PlateRectShape(0, 0, 1000, 400, MonacoColors.flagRed),
  ]);

  static const PlateCountry monaco = PlateCountry(
    code: 'mc',
    panelColor: MonacoColors.badgeBlue,
    panelTextColor: MonacoColors.white,
    flagAspectRatio: 5 / 4,
    flag: _flag,
  );
}
