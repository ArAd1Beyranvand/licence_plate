import 'package:license_plate/core/plate_core.dart';

import 'zambia_colors.dart';

abstract final class ZambiaCountry {
  static const PlateCountry zambia = PlateCountry(
    code: 'zm',
    panelColor: ZambiaColors.white,
    panelTextColor: ZambiaColors.red,
  );
}
