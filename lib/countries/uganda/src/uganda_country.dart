import 'package:license_plate/core/plate_core.dart';

import 'uganda_colors.dart';

/// No side band; the flag is a decal on the spec.
abstract final class UgandaCountry {
  static const PlateCountry uganda = PlateCountry(
    code: 'ug',
    panelColor: UgandaColors.yellow,
    panelTextColor: UgandaColors.red,
  );
}
