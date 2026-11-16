import 'package:license_plate/core/plate_core.dart';

import 'pakistan_colors.dart';

/// Pakistan as a `PlateCountry`. No Pakistani plate prints a country block —
/// the province's own name and arms are on the face — so every spec sets
/// `noPanel` and this carries only the flag for hosts that list countries.
abstract final class PakistanCountry {
  /// The flag at 900×600: a white hoist quarter on a green field, and a
  /// crescent and star. The engine's crescent has no rotation, so it opens to
  /// the right rather than to the upper right as on the flag.
  static const PlateDrawing _flag = PlateDrawing(900, 600, <PlateShape>[
    PlateRectShape(0, 0, 900, 600, PakistanColors.flagGreen),
    PlateRectShape(0, 0, 225, 600, PakistanColors.white),
    PlateCrescentShape(562.5, 300, 180, 40, 150, PakistanColors.white),
    PlateStarShape(640, 300, 54, PakistanColors.white, rotation: 90),
  ]);

  static const PlateCountry pakistan = PlateCountry(
    code: 'pk',
    panelColor: PakistanColors.flagGreen,
    panelTextColor: PakistanColors.white,
    flagAspectRatio: 3 / 2,
    flag: _flag,
  );
}
