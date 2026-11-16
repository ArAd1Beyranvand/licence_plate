import 'package:license_plate/core/plate_core.dart';

import 'nauru_colors.dart';

/// Nauru as a `PlateCountry`. The plates carry no flag or country block, only
/// the word NAURU as a label, so every spec sets `noPanel`.
abstract final class NauruCountry {
  static const PlateCountry nauru = PlateCountry(
    code: 'nr',
    panelColor: NauruColors.field,
    panelTextColor: NauruColors.ink,
  );
}
