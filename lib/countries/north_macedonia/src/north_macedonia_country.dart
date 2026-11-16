import 'package:license_plate/core/plate_core.dart';

import 'north_macedonia_colors.dart';

/// North Macedonia as a `PlateCountry`: only the blue side band. The code
/// printed on it (`NMK`, formerly `MK`) is a `PlateLabel` on each spec, so
/// [captionLines] is empty and there is no flag.
abstract final class NorthMacedoniaCountry {
  static const PlateCountry north_macedonia = PlateCountry(
    code: 'mk',
    panelColor: NorthMacedoniaColors.band,
    panelTextColor: NorthMacedoniaColors.white,
  );
}
