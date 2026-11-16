import 'package:license_plate/core/plate_core.dart';

import 'lesotho_colors.dart';

/// The plates carry no country block, so the spec sets `noPanel`.
abstract final class LesothoCountry {
  static const PlateCountry lesotho = PlateCountry(
    code: 'ls',
    panelColor: LesothoColors.white,
    panelTextColor: LesothoColors.blue,
  );
}
