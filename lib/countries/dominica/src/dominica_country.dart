import 'package:license_plate/core/plate_core.dart';

import 'dominica_colors.dart';

abstract final class DominicaCountry {
  static const PlateCountry dominica = PlateCountry(
    code: 'dm',
    panelColor: DominicaColors.black,
    panelTextColor: DominicaColors.silver,
  );
}
