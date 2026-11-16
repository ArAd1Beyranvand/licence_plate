import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'greece_colors.dart';

/// The euroband: the Flag of Europe over a white `GR`. Plates without the band
/// set `noPanel`.
abstract final class GreeceCountry {
  static const PlateCountry greece = PlateCountry(
    code: 'gr',
    captionLines: <String>['GR'],
    panelColor: GreeceColors.euroBlue,
    panelTextColor: GreeceColors.white,
    flagAspectRatio: 3 / 2,
    flag: EuropeanStars.band,
  );

  static const EdgeInsets panelPadding = EdgeInsets.symmetric(
    horizontal: 7,
    vertical: 11,
  );
}
