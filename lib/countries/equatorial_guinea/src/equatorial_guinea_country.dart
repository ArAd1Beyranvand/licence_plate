import 'package:license_plate/core/plate_core.dart';

import 'equatorial_guinea_colors.dart';

abstract final class EquatorialGuineaCountry {
  static const PlateCountry equatorial_guinea = PlateCountry(
    code: 'gq',
    panelColor: EquatorialGuineaColors.white,
    panelTextColor: EquatorialGuineaColors.black,
  );
}
