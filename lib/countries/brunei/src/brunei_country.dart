import 'package:license_plate/core/plate_core.dart';

import 'brunei_colors.dart';

/// Every spec sets `noPanel`; the colours are only the required placeholders.
abstract final class BruneiCountry {
  static const PlateCountry brunei = PlateCountry(
    code: 'bn',
    panelColor: BruneiColors.black,
    panelTextColor: BruneiColors.lightInk,
  );
}
