import 'package:license_plate/core/plate_core.dart';

import 'fiji_colors.dart';

/// Fiji as a `PlateCountry`. The plates carry no country block and no flag
/// (the page flag is only an illustration), so every spec sets `noPanel`.
abstract final class FijiCountry {
  static const PlateCountry fiji = PlateCountry(
    code: 'fj',
    panelColor: FijiColors.white,
    panelTextColor: FijiColors.ink,
  );
}
