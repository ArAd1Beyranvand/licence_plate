import 'package:license_plate/core/plate_core.dart';

import 'japan_colors.dart';

/// No plate carries a country block, so every spec sets `noPanel`; the export
/// plate's flag is drawn on the face.
abstract final class JapanCountry {
  static const PlateCountry japan = PlateCountry(
    code: 'jp',
    panelColor: JapanColors.white,
    panelTextColor: JapanColors.green,
  );
}
