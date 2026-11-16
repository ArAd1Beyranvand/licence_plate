import 'package:license_plate/core/plate_core.dart';

import 'saint_lucia_colors.dart';

/// The plates print no strip or flag, so only the code matters.
abstract final class SaintLuciaCountry {
  static const PlateCountry saint_lucia = PlateCountry(
    code: 'lc',
    panelColor: SaintLuciaColors.black,
    panelTextColor: SaintLuciaColors.white,
  );
}
