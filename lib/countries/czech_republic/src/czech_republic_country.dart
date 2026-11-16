import 'package:license_plate/core/plate_core.dart';

import 'czech_republic_colors.dart';

/// The Czech Republic as a `PlateCountry`: the EU band, drawn with
/// `EuropeanStars.band`. The `CZ` beneath the stars is a [PlateLabel] on the
/// spec, so [captionLines] is empty. The Czech national flag is not printed on
/// the plates and is not drawn.
abstract final class CzechRepublicCountry {
  static const PlateCountry czech_republic = PlateCountry(
    code: 'cz',
    panelColor: CzechRepublicColors.euroBlue,
    panelTextColor: CzechRepublicColors.white,
    flagAspectRatio: 41.5 / 63.5,
    flag: EuropeanStars.band,
  );
}
