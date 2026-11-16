import 'package:license_plate/core/plate_core.dart';

import 'gabon_colors.dart';

abstract final class GabonCountry {
  static const PlateCountry gabon = PlateCountry(
    code: 'ga',
    panelColor: GabonColors.yellow,
    panelTextColor: GabonColors.black,
  );
}
