import 'package:license_plate/core/plate_core.dart';

import 'guinea_colors.dart';

/// Guinea as a `PlateCountry`. The plates carry no country block (the "RG" is
/// a label on the face), so every spec sets `noPanel`.
abstract final class GuineaCountry {
  static const PlateCountry guinea = PlateCountry(
    code: 'gn',
    panelColor: GuineaColors.white,
    panelTextColor: GuineaColors.blue,
  );
}
