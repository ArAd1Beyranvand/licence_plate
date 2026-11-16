import 'package:license_plate/core/plate_core.dart';

import 'canada_colors.dart';

/// Plates are issued per province and carry no shared country block, so every
/// spec sets `noPanel`.
abstract final class CanadaCountry {
  static const PlateCountry canada = PlateCountry(
    code: 'ca',
    panelColor: CanadaColors.federalField,
    panelTextColor: CanadaColors.federalInk,
  );
}
