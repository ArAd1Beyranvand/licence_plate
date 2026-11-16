import 'package:license_plate/core/plate_core.dart';

import 'ukraine_colors.dart';

/// Ukraine as a `PlateCountry`. The flag is two stripes, so it is a
/// `PlateDrawing`, not an asset.
abstract final class UkraineCountry {
  static const PlateCountry ukraine = PlateCountry(
    code: 'ua',
    captionLines: <String>['UA'],
    panelColor: UkraineColors.bandBlue,
    panelTextColor: UkraineColors.white,
    flagAspectRatio: 3 / 2,
    flag: PlateDrawing(3, 2, <PlateShape>[
      PlateRectShape(0, 0, 3, 1, UkraineColors.flagBlue),
      PlateRectShape(0, 1, 3, 1, UkraineColors.flagYellow),
    ]),
  );
}
