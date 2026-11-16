import 'package:license_plate/core/plate_core.dart';

import 'saba_island_colors.dart';

/// Saba (a Caribbean Netherlands island) as a `PlateCountry`. No plate carries
/// a country block, so every spec sets `noPanel`.
abstract final class SabaIslandCountry {
  static const PlateCountry saba_island = PlateCountry(
    code: 'bq',
    panelColor: SabaIslandColors.green,
    panelTextColor: SabaIslandColors.white,
  );
}
