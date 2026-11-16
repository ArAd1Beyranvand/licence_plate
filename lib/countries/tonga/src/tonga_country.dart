import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'tonga_colors.dart';

/// Tonga as a `PlateCountry`. The plate prints the word TONGA but no country
/// block, so every spec sets `noPanel`; this carries the flag for hosts that
/// list countries.
///
/// The flag is drawn from the Commons construction (96×48): a red field, a
/// white 40×24 canton, and a red cross 6 wide centred in it.
abstract final class TongaCountry {
  static const PlateDrawing _flag = PlateDrawing(96, 48, <PlateShape>[
    PlateRectShape(0, 0, 96, 48, TongaColors.flagRed),
    PlateRectShape(0, 0, 40, 24, Color(0xFFFFFFFF)),
    PlateRectShape(17, 3, 6, 18, TongaColors.flagRed),
    PlateRectShape(11, 9, 18, 6, TongaColors.flagRed),
  ]);

  static const PlateCountry tonga = PlateCountry(
    code: 'to',
    panelColor: TongaColors.field,
    panelTextColor: TongaColors.ink,
    flagAspectRatio: 2,
    flag: _flag,
  );
}
