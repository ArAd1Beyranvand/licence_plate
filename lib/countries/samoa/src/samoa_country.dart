import 'package:license_plate/core/plate_core.dart';

import 'samoa_colors.dart';

/// Samoa as a `PlateCountry`. No plate carries a country block or flag, so
/// every spec sets `noPanel`.
abstract final class SamoaCountry {
  static const PlateCountry samoa = PlateCountry(
    code: 'ws',
    panelColor: SamoaColors.whiteField,
    panelTextColor: SamoaColors.blue,
  );
}
