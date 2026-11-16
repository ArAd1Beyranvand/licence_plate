import 'package:license_plate/core/plate_core.dart';

import 'singapore_colors.dart';

/// Singapore as a `PlateCountry`. No Singaporean plate prints a flag or a
/// country block, so every spec sets `noPanel` and this carries only the flag
/// for hosts that list countries.
abstract final class SingaporeCountry {
  /// `Flag_of_Singapore.svg` (54×36) scaled to 900×600: red over white, a
  /// crescent and a ring of five stars. Each star has outer radius 28.73 and
  /// sits 63.35 from the ring's centre (250.5, 150), tips outward.
  static const PlateDrawing _flag = PlateDrawing(900, 600, <PlateShape>[
    PlateRectShape(0, 0, 900, 600, SingaporeColors.flagWhite),
    PlateRectShape(0, 0, 900, 300, SingaporeColors.flagRed),
    PlateCrescentShape(
      190.083,
      150,
      110.417,
      60.417,
      120.833,
      SingaporeColors.flagWhite,
    ),
    PlateStarShape(250.5, 86.65, 28.73, SingaporeColors.flagWhite),
    PlateStarShape(
      310.75,
      130.42,
      28.73,
      SingaporeColors.flagWhite,
      rotation: 72,
    ),
    PlateStarShape(
      287.73,
      201.25,
      28.73,
      SingaporeColors.flagWhite,
      rotation: 144,
    ),
    PlateStarShape(
      213.27,
      201.25,
      28.73,
      SingaporeColors.flagWhite,
      rotation: 216,
    ),
    PlateStarShape(
      190.25,
      130.42,
      28.73,
      SingaporeColors.flagWhite,
      rotation: 288,
    ),
  ]);

  static const PlateCountry singapore = PlateCountry(
    code: 'sg',
    panelColor: SingaporeColors.flagRed,
    panelTextColor: SingaporeColors.flagWhite,
    flagAspectRatio: 3 / 2,
    flag: _flag,
  );
}
