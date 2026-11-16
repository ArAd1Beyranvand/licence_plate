import 'package:license_plate/core/plate_core.dart';

import 'honduras_colors.dart';

/// Honduras as a `PlateCountry`. The flag sits in the blue band as a decal on
/// the spec, so every spec sets `noPanel`; this carries it for hosts that list
/// countries.
///
/// The flag is drawn in code from the Commons SVG's 72×36 construction: blue,
/// white, blue stripes and five stars in the white one.
abstract final class HondurasCountry {
  static const PlateDrawing flag = PlateDrawing(72, 36, <PlateShape>[
    PlateRectShape(0, 0, 72, 36, HondurasColors.white),
    PlateRectShape(0, 0, 72, 12, HondurasColors.flagBlue),
    PlateRectShape(0, 24, 72, 12, HondurasColors.flagBlue),
    PlateStarShape(26, 15, 2, HondurasColors.flagBlue),
    PlateStarShape(26, 21, 2, HondurasColors.flagBlue),
    PlateStarShape(36, 18, 2, HondurasColors.flagBlue),
    PlateStarShape(46, 15, 2, HondurasColors.flagBlue),
    PlateStarShape(46, 21, 2, HondurasColors.flagBlue),
  ]);

  static const PlateCountry honduras = PlateCountry(
    code: 'hn',
    panelColor: HondurasColors.blue,
    panelTextColor: HondurasColors.white,
    flagAspectRatio: 2,
    flag: flag,
  );
}
