import 'package:license_plate/core/plate_core.dart';

import 'kiribati_colors.dart';

/// Kiribati as a `PlateCountry`. The plates carry no flag or country block, so
/// every spec sets `noPanel`.
abstract final class KiribatiCountry {
  static const PlateCountry kiribati = PlateCountry(
    code: 'ki',
    panelColor: KiribatiColors.field,
    panelTextColor: KiribatiColors.ink,
  );
}
