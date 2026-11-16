import 'package:license_plate/core/plate_core.dart';

import 'rwanda_colors.dart';

/// The plate carries no country block, so the spec sets `noPanel`.
abstract final class RwandaCountry {
  static const PlateCountry rwanda = PlateCountry(
    code: 'rw',
    panelColor: RwandaColors.white,
    panelTextColor: RwandaColors.black,
  );
}
