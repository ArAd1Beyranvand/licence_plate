import 'package:license_plate/core/plate_core.dart';

import 'peru_colors.dart';

/// Peru as a `PlateCountry`. No plate prints a country block — the flag and
/// the word PERU are a decal and a label on each spec — so every spec sets
/// `noPanel` and this carries the flag for hosts that list countries.
abstract final class PeruCountry {
  /// Three equal vertical stripes, without the shield, as the article says the
  /// plates show it.
  static const PlateDrawing flag = PlateDrawing(900, 600, <PlateShape>[
    PlateRectShape(0, 0, 300, 600, PeruColors.flagRed),
    PlateRectShape(300, 0, 300, 600, PeruColors.flagWhite),
    PlateRectShape(600, 0, 300, 600, PeruColors.flagRed),
  ]);

  static const PlateCountry peru = PlateCountry(
    code: 'pe',
    panelColor: PeruColors.white,
    panelTextColor: PeruColors.black,
    flagAspectRatio: 3 / 2,
    flag: flag,
  );
}
