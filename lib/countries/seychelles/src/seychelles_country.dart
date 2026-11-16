import 'package:license_plate/core/plate_core.dart';

import 'seychelles_colors.dart';

/// Seychelles as a `PlateCountry`. The plates carry no country block.
abstract final class SeychellesCountry {
  static const PlateCountry seychelles = PlateCountry(
    code: 'sc',
    panelColor: SeychellesColors.black,
    panelTextColor: SeychellesColors.white,
  );
}
