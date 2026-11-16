import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'burundi_colors.dart';

/// Burundi as a `PlateCountry`. The plates carry no coloured country block:
/// the flag and "BU" sit on the field at the left, as a decal and a label on
/// the spec, so every spec sets `noPanel`.
abstract final class BurundiCountry {
  /// The flag, 500×300: a white saltire over red (top, bottom) and green
  /// (left, right) triangles, and a white disc with three stars.
  static const PlateDrawing flag = PlateDrawing(500, 300, <PlateShape>[
    PlateRectShape(0, 0, 500, 300, BurundiColors.white),
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(500, 0),
      Offset(250, 150),
    ], BurundiColors.flagRed),
    PlatePolygonShape(<Offset>[
      Offset(0, 300),
      Offset(500, 300),
      Offset(250, 150),
    ], BurundiColors.flagRed),
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(0, 300),
      Offset(250, 150),
    ], BurundiColors.flagGreen),
    PlatePolygonShape(<Offset>[
      Offset(500, 0),
      Offset(500, 300),
      Offset(250, 150),
    ], BurundiColors.flagGreen),
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(60, 0),
      Offset(500, 300),
      Offset(440, 300),
    ], BurundiColors.white),
    PlatePolygonShape(<Offset>[
      Offset(440, 0),
      Offset(500, 0),
      Offset(60, 300),
      Offset(0, 300),
    ], BurundiColors.white),
    PlateCircleShape(250, 150, 90, BurundiColors.white),
    PlateStarShape(250, 112, 26, BurundiColors.flagGreen),
    PlateStarShape(217, 172, 26, BurundiColors.flagGreen),
    PlateStarShape(283, 172, 26, BurundiColors.flagGreen),
    PlateStarShape(250, 112, 19, BurundiColors.flagRed),
    PlateStarShape(217, 172, 19, BurundiColors.flagRed),
    PlateStarShape(283, 172, 19, BurundiColors.flagRed),
  ]);

  static const PlateCountry burundi = PlateCountry(
    code: 'bi',
    panelColor: BurundiColors.white,
    panelTextColor: BurundiColors.black,
    flagAspectRatio: 5 / 3,
    flag: flag,
  );
}
