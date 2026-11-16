import 'package:license_plate/core/plate_core.dart';

import 'transnistria_colors.dart';

/// The flag is stripes, so it is a `PlateDrawing`. Bands measured off the
/// passenger artwork: red 0.375, green 0.25, red 0.375 of a 2:1 flag.
abstract final class TransnistriaCountry {
  static const PlateDrawing flagDrawing = PlateDrawing(2, 1, <PlateShape>[
    PlateRectShape(0, 0, 2, 1, TransnistriaColors.flagRed),
    PlateRectShape(0, 0.375, 2, 0.25, TransnistriaColors.flagGreen),
  ]);

  /// The same flag as the state plates print it.
  static const PlateDrawing stateFlagDrawing = PlateDrawing(2, 1, <PlateShape>[
    PlateRectShape(0, 0, 2, 1, TransnistriaColors.stateRed),
    PlateRectShape(0, 0.375, 2, 0.25, TransnistriaColors.stateGreen),
  ]);

  static const PlateCountry transnistria = PlateCountry(
    code: 'pmr',
    captionLines: <String>['PMR'],
    panelColor: TransnistriaColors.white,
    panelTextColor: TransnistriaColors.black,
    flagAspectRatio: 2,
    flag: flagDrawing,
  );
}
