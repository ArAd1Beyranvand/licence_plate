import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'palau_colors.dart';

/// Palau as a `PlateCountry`. No plate prints a country block — the state is
/// named in the plate's own header — so every spec sets `noPanel` and this
/// carries only the flag for hosts that list countries.
abstract final class PalauCountry {
  /// `Flag_of_Palau.svg`, 800×500: a golden disc off-centre on light blue.
  static const PlateDrawing _flag = PlateDrawing(800, 500, <PlateShape>[
    PlateRectShape(0, 0, 800, 500, PalauColors.flagBlue),
    PlateCircleShape(350, 250, 150, PalauColors.flagYellow),
  ]);

  static const PlateCountry palau = PlateCountry(
    code: 'pw',
    panelColor: PalauColors.flagBlue,
    panelTextColor: Color(0xFFFFFFFF),
    flagAspectRatio: 8 / 5,
    flag: _flag,
  );
}
