import 'package:license_plate/core/plate_core.dart';

import 'ethiopia_colors.dart';

/// The plates print no flag or country block, so every spec sets `noPanel`;
/// this is for hosts that list countries.
abstract final class EthiopiaCountry {
  static const PlateCountry ethiopia = PlateCountry(
    code: 'et',
    panelColor: EthiopiaColors.blue,
    panelTextColor: EthiopiaColors.white,
  );
}
