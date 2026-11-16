import 'package:license_plate/core/plate_core.dart';

import 'hungary_colors.dart';

/// Hungary as a `PlateCountry`. The 2022 plate, the diplomatic and the staff
/// plate carry the EU ring with `EuropeanStars.band` and a printed `H`
/// ([PlateLabel] on the spec), so [captionLines] is empty. The older-style
/// plates carry the national tricolour in a side strip instead.
abstract final class HungaryCountry {
  static const PlateCountry hungary = PlateCountry.euroband(
    code: 'hu',
    panelColor: HungaryColors.euroBlue,
    panelTextColor: HungaryColors.white,
  );

  /// The diplomatic plate's ring sits on the blue field itself.
  static const PlateCountry diplomatic = PlateCountry.euroband(
    code: 'hu',
    panelColor: HungaryColors.diplomaticField,
    panelTextColor: HungaryColors.diplomaticInk,
  );

  static const PlateCountry staff = PlateCountry.euroband(
    code: 'hu',
    panelColor: HungaryColors.staffStrip,
    panelTextColor: HungaryColors.white,
  );

  /// Red, white, green, three equal bands, on a square block: the flag is
  /// squeezed on the plate (31 × 32.5 on the trial plate).
  static const PlateCountry tricolour = PlateCountry(
    code: 'hu',
    panelColor: HungaryColors.white,
    panelTextColor: HungaryColors.black,
    flagAspectRatio: 1,
    flag: PlateDrawing(30, 30, <PlateShape>[
      PlateRectShape(0, 0, 30, 10, HungaryColors.flagRed),
      PlateRectShape(0, 10, 30, 10, HungaryColors.white),
      PlateRectShape(0, 20, 30, 10, HungaryColors.flagGreen),
    ]),
  );
}
