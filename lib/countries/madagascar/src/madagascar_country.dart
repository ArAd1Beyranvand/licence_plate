import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'madagascar_colors.dart';

/// Only the military plate prints a country block (the flag); the other specs
/// set `noPanel`.
abstract final class MadagascarCountry {
  static const PlateDrawing _flag = PlateDrawing(900, 600, <PlateShape>[
    PlateRectShape(0, 0, 900, 600, Color(0xFF00843D)),
    PlateRectShape(0, 0, 900, 300, Color(0xFFF9423A)),
    PlateRectShape(0, 0, 300, 600, Color(0xFFFFFFFF)),
  ]);

  static const PlateCountry madagascar = PlateCountry(
    code: 'mg',
    panelColor: MadagascarColors.militaryField,
    panelTextColor: MadagascarColors.militaryInk,
    flagAspectRatio: 3 / 2,
    flag: _flag,
  );
}
