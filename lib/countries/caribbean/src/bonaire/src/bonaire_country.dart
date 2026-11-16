import 'package:license_plate/core/plate_core.dart';

import 'bonaire_colors.dart';

/// Bonaire (with St. Eustatius and Saba, the Caribbean Netherlands) as a
/// `PlateCountry`. No plate carries a country block, so every spec sets
/// `noPanel`.
abstract final class BonaireCountry {
  static const PlateCountry bonaire = PlateCountry(
    code: 'bq',
    panelColor: BonaireColors.white,
    panelTextColor: BonaireColors.black,
  );
}
