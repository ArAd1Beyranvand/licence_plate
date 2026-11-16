import 'package:license_plate/core/plate_core.dart';

import 'marshall_islands_colors.dart';

/// The Marshall Islands as a `PlateCountry`. The plates carry no flag or
/// country block, only the name as a label, so every spec sets `noPanel`.
abstract final class MarshallIslandsCountry {
  static const PlateCountry marshall_islands = PlateCountry(
    code: 'mh',
    panelColor: MarshallIslandsColors.field,
    panelTextColor: MarshallIslandsColors.ink,
  );
}
