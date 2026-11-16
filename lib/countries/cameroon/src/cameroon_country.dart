import 'package:license_plate/core/plate_core.dart';

import 'cameroon_colors.dart';

/// The spec paints the emblem and `CMR` itself, so every spec sets `noPanel`.
abstract final class CameroonCountry {
  static const PlateCountry cameroon = PlateCountry(
    code: 'cm',
    panelColor: CameroonColors.orange,
    panelTextColor: CameroonColors.black,
  );
}
