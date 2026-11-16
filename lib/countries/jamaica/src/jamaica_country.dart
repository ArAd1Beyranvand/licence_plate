import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'jamaica_colors.dart';

/// The plate prints no country block, so every spec sets `noPanel`; the flag
/// is carried for hosts that list countries. 1200×600: a gold saltire 100 wide
/// over green (top, bottom) and black (hoist, fly) triangles.
abstract final class JamaicaCountry {
  static const PlateDrawing _flag = PlateDrawing(1200, 600, <PlateShape>[
    PlateRectShape(0, 0, 1200, 600, JamaicaColors.flagGold),
    PlatePolygonShape(<Offset>[
      Offset(112, 0),
      Offset(1088, 0),
      Offset(600, 244),
    ], JamaicaColors.flagGreen),
    PlatePolygonShape(<Offset>[
      Offset(112, 600),
      Offset(1088, 600),
      Offset(600, 356),
    ], JamaicaColors.flagGreen),
    PlatePolygonShape(<Offset>[
      Offset(0, 56),
      Offset(0, 544),
      Offset(488, 300),
    ], JamaicaColors.flagBlack),
    PlatePolygonShape(<Offset>[
      Offset(1200, 56),
      Offset(1200, 544),
      Offset(712, 300),
    ], JamaicaColors.flagBlack),
  ]);

  static const PlateCountry jamaica = PlateCountry(
    code: 'jm',
    panelColor: JamaicaColors.flagGreen,
    panelTextColor: JamaicaColors.flagBlack,
    flagAspectRatio: 2 / 1,
    flag: _flag,
  );
}
