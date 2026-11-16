import 'package:license_plate/core/plate_core.dart';

import 'argentina_colors.dart';

/// Argentina as a `PlateCountry`. No Argentine plate prints a country block —
/// the Mercosur flag is a decal on the spec — so every spec sets `noPanel` and
/// this carries only the flag for hosts that list countries.
abstract final class ArgentinaCountry {
  /// Three equal stripes (9:14) and the Sun of May as a plain disc: its 32
  /// rays are below the 20-unit size it prints at on the plate.
  static const PlateDrawing flag = PlateDrawing(140, 90, <PlateShape>[
    PlateRectShape(0, 0, 140, 30, ArgentinaColors.flagBlue),
    PlateRectShape(0, 30, 140, 30, ArgentinaColors.white),
    PlateRectShape(0, 60, 140, 30, ArgentinaColors.flagBlue),
    PlateCircleShape(70, 45, 13.5, ArgentinaColors.flagSun),
  ]);

  static const PlateCountry argentina = PlateCountry(
    code: 'ar',
    captionLines: <String>['RA'],
    panelColor: ArgentinaColors.mercosurBlue,
    panelTextColor: ArgentinaColors.white,
    flagAspectRatio: 14 / 9,
    flag: flag,
  );
}
