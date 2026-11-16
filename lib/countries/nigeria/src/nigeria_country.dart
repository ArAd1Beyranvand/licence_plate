import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'nigeria_colors.dart';

/// Nigeria as a `PlateCountry`. The plate has no country block — the flag is
/// a decal on the face — so every spec sets `noPanel`.
abstract final class NigeriaCountry {
  /// Green-white-green in vertical thirds.
  static const PlateDrawing flag = PlateDrawing(900, 600, <PlateShape>[
    PlateRectShape(0, 0, 900, 600, Color(0xFFFFFFFF)),
    PlateRectShape(0, 0, 300, 600, NigeriaColors.flagGreen),
    PlateRectShape(600, 0, 300, 600, NigeriaColors.flagGreen),
  ]);

  static const PlateCountry nigeria = PlateCountry(
    code: 'ng',
    panelColor: NigeriaColors.flagGreen,
    panelTextColor: NigeriaColors.white,
    flagAspectRatio: 2,
    flag: flag,
  );
}
