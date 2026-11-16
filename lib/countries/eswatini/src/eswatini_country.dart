import 'package:license_plate/core/plate_core.dart';

import 'eswatini_colors.dart';

/// Eswatini as a `PlateCountry`. The plates copy the South African design: a
/// printed landscape and no flag or country strip, so every spec sets
/// `noPanel`. The flag on the source page is not plate content.
abstract final class EswatiniCountry {
  static const PlateCountry eswatini = PlateCountry(
    code: 'sz',
    captionLines: <String>['SZ'],
    panelColor: EswatiniColors.field,
    panelTextColor: EswatiniColors.ink,
  );
}
