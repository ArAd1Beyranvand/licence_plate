import 'package:license_plate/core/plate_core.dart';

import 'gambia_colors.dart';

abstract final class GambiaCountry {
  static const PlateCountry gambia = PlateCountry(
    code: 'gm',
    panelColor: GambiaColors.white,
    panelTextColor: GambiaColors.black,
  );
}
