import 'package:license_plate/core/plate_core.dart';

import 'san_marino_colors.dart';

/// San Marino as a `PlateCountry`. The plates carry no flag, band or country
/// code (the coat of arms is a decal on the face), so there is no panel.
abstract final class SanMarinoCountry {
  static const PlateCountry san_marino = PlateCountry(
    code: 'sm',
    panelColor: SanMarinoColors.blue,
    panelTextColor: SanMarinoColors.field,
  );
}
