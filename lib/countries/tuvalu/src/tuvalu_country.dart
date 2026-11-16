import 'package:license_plate/core/plate_core.dart';

import 'tuvalu_colors.dart';

/// Tuvalu as a `PlateCountry`. The plate carries no flag or country block, so
/// every spec sets `noPanel`.
abstract final class TuvaluCountry {
  static const PlateCountry tuvalu = PlateCountry(
    code: 'tv',
    panelColor: TuvaluColors.field,
    panelTextColor: TuvaluColors.ink,
  );
}
