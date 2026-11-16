import 'package:license_plate/core/plate_core.dart';

import 'china_colors.dart';

/// China as a `PlateCountry`. No Chinese plate prints a country block, so
/// every spec sets `noPanel`; this carries the flag for hosts that list
/// countries.
///
/// The flag is drawn in the official 30×20 construction scaled by 30: the big
/// star's centre at (5, 5) with radius 3, the four small stars (radius 1) at
/// (10, 2), (12, 4), (12, 7) and (10, 9), each with one point aimed at the
/// big star's centre.
abstract final class ChinaCountry {
  static const PlateDrawing _flag = PlateDrawing(900, 600, <PlateShape>[
    PlateRectShape(0, 0, 900, 600, ChinaColors.flagRed),
    PlateStarShape(150, 150, 90, ChinaColors.flagYellow),
    PlateStarShape(300, 60, 30, ChinaColors.flagYellow, rotation: 239.04),
    PlateStarShape(360, 120, 30, ChinaColors.flagYellow, rotation: 261.87),
    PlateStarShape(360, 210, 30, ChinaColors.flagYellow, rotation: 285.95),
    PlateStarShape(300, 270, 30, ChinaColors.flagYellow, rotation: 308.66),
  ]);

  static const PlateCountry china = PlateCountry(
    code: 'cn',
    panelColor: ChinaColors.flagRed,
    panelTextColor: ChinaColors.flagYellow,
    flagAspectRatio: 3 / 2,
    flag: _flag,
  );
}
