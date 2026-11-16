import 'package:license_plate/core/plate_core.dart';

import 'sovereign_military_order_of_malta_colors.dart';

/// The Order as a `PlateCountry`. Its plate carries no flag, band or country
/// code, so there is no panel; the arms on the face are a decal on the spec.
abstract final class SovereignMilitaryOrderOfMaltaCountry {
  static const PlateCountry sovereign_military_order_of_malta = PlateCountry(
    code: 'smom',
    panelColor: SovereignMilitaryOrderOfMaltaColors.red,
    panelTextColor: SovereignMilitaryOrderOfMaltaColors.white,
  );
}
