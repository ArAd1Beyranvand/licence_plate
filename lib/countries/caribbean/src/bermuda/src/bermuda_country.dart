import 'package:license_plate/core/plate_core.dart';

import 'bermuda_colors.dart';

/// Bermuda as a `PlateCountry`. The plate prints no country block or flag
/// (the flag on the article page is not on any plate), so every spec sets
/// `noPanel`.
abstract final class BermudaCountry {
  static const PlateCountry bermuda = PlateCountry(
    code: 'bm',
    panelColor: BermudaColors.white,
    panelTextColor: BermudaColors.black,
  );
}
