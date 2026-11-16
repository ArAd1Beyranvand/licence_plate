import 'package:license_plate/core/plate_core.dart';

import 'andorra_colors.dart';

/// Andorra as a `PlateCountry`. The plates have no country block: the coat of
/// arms is a decal and "AND" a label on each spec, so the panel is unused.
abstract final class AndorraCountry {
  static const PlateCountry andorra = PlateCountry(
    code: 'ad',
    panelColor: AndorraColors.blue,
    panelTextColor: AndorraColors.white,
  );
}
