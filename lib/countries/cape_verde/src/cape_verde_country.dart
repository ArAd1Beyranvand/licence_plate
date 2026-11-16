import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'cape_verde_colors.dart';

/// Only the military plate prints a country block (the flag on a blue strip);
/// the other specs set `noPanel`.
abstract final class CapeVerdeCountry {
  static const PlateDrawing _flag = PlateDrawing(1020, 600, <PlateShape>[
    PlateRectShape(0, 0, 1020, 600, Color(0xFF003893)),
    PlateRectShape(0, 300, 1020, 150, Color(0xFFFFFFFF)),
    PlateRectShape(0, 350, 1020, 50, Color(0xFFCF2027)),
    PlateStarRingShape(382.5, 375, 150, 27.64, 10, Color(0xFFF7D116)),
  ]);

  static const PlateCountry cape_verde = PlateCountry(
    code: 'cv',
    panelColor: CapeVerdeColors.flagBlue,
    panelTextColor: CapeVerdeColors.white,
    flagAspectRatio: 17 / 10,
    // https://commons.wikimedia.org/wiki/File:Flag_of_Cape_Verde_(10-17).svg
    flag: _flag,
  );
}
