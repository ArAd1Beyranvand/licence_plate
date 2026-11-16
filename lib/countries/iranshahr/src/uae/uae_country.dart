import 'package:license_plate/core/plate_core.dart';

import 'uae_colors.dart';

/// The block a UAE plate would put in its panel. No UAE design has one — every
/// emirate prints its name as text on the face, which the specs carry as
/// labels — so every spec is `noPanel` and this exists only because
/// `PlateCanvas` takes a country.
abstract final class UaeCountry {
  static const PlateCountry uae = PlateCountry(
    code: 'ae',
    panelColor: UaeColors.field,
    panelTextColor: UaeColors.ink,
    flag: flag,
    flagAspectRatio: 2,
  );

  /// The national flag, 2:1: a red hoist a quarter of the width, then green,
  /// white and black stripes.
  static const PlateDrawing flag = PlateDrawing(12, 6, <PlateShape>[
    PlateRectShape(0, 0, 12, 6, UaeColors.field),
    PlateRectShape(3, 0, 9, 2, UaeColors.flagGreen),
    PlateRectShape(3, 4, 9, 2, UaeColors.ink),
    PlateRectShape(0, 0, 3, 6, UaeColors.flagRed),
  ]);
}
