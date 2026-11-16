import 'package:license_plate/core/plate_core.dart';

import 'chad_colors.dart';

/// Chad as a `PlateCountry`. The CEMAC block and "TCH" are labels on the
/// face, so every spec sets `noPanel`.
abstract final class ChadCountry {
  static const PlateCountry chad = PlateCountry(
    code: 'td',
    panelColor: ChadColors.white,
    panelTextColor: ChadColors.black,
  );
}
