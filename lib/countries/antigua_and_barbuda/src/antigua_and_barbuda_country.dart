import 'package:license_plate/core/plate_core.dart';

import 'antigua_and_barbuda_colors.dart';

/// The plates carry no country block, so the specs set `noPanel`.
abstract final class AntiguaAndBarbudaCountry {
  static const PlateCountry antigua_and_barbuda = PlateCountry(
    code: 'ag',
    panelColor: AntiguaAndBarbudaColors.white,
    panelTextColor: AntiguaAndBarbudaColors.black,
  );
}
