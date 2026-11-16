import 'package:license_plate/core/plate_core.dart';

import 'french_guiana_colors.dart';

abstract final class FrenchGuianaCountry {
  /// The Guyane logo: blue sky, green forest, a yellow band, an orange
  /// stripe. A simplified drawing, not a trace of the original.
  static const PlateDrawing logo = PlateDrawing(36, 39, <PlateShape>[
    PlateRectShape(0, 0, 36, 39, FrenchGuianaColors.white),
    PlateRectShape(3, 8, 31, 12, FrenchGuianaColors.logoBlue),
    PlateRectShape(3, 20, 31, 9, FrenchGuianaColors.logoGreen),
    PlateRectShape(9, 23, 18, 3, FrenchGuianaColors.logoYellow),
    PlateRectShape(2, 31, 33, 3, FrenchGuianaColors.logoOrange),
  ]);

  // ignore: constant_identifier_names
  static const PlateCountry french_guiana = PlateCountry(
    code: 'gf',
    captionLines: <String>['F'],
    panelColor: FrenchGuianaColors.band,
    panelTextColor: FrenchGuianaColors.white,
    flagAspectRatio: 3 / 2,
  );
}
