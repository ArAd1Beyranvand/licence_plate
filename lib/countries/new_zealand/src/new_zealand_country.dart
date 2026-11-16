import 'package:license_plate/core/plate_core.dart';

import 'new_zealand_colors.dart';

/// New Zealand as a `PlateCountry`. No spec carries a country block; the
/// Europlate bands are painted by its own background.
abstract final class NewZealandCountry {
  static const PlateCountry new_zealand = PlateCountry(
    code: 'nz',
    panelColor: NewZealandColors.blue,
    panelTextColor: NewZealandColors.silver,
  );
}
