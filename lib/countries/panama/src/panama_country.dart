import 'package:license_plate/core/plate_core.dart';

import 'panama_colors.dart';

/// Panama as a `PlateCountry`. The plates carry no country block, only the
/// word PANAMA, so every spec sets `noPanel`. The flag is not printed on them.
abstract final class PanamaCountry {
  static const PlateCountry panama = PlateCountry(
    code: 'pa',
    panelColor: PanamaColors.white,
    panelTextColor: PanamaColors.black,
  );
}
