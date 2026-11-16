import 'package:license_plate/core/plate_core.dart';

import 'solomon_islands_colors.dart';

/// Solomon Islands as a `PlateCountry`. The plate carries no flag or country
/// block, only a caption line, so every spec sets `noPanel`.
abstract final class SolomonIslandsCountry {
  static const PlateCountry solomon_islands = PlateCountry(
    code: 'sb',
    panelColor: SolomonIslandsColors.field,
    panelTextColor: SolomonIslandsColors.ink,
  );
}
