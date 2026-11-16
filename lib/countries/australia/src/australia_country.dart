import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'australia_colors.dart';

/// Australia as a `PlateCountry`. No Australian plate prints a country block,
/// so every spec sets `noPanel` and this carries only the flag for hosts that
/// list countries.
///
/// The flag is drawn in code on the SVG's own 10080×5040 grid
/// (`Flag_of_Australia_(converted).svg`, Wikimedia Commons): the Union Jack
/// canton is 5040×2520, the Commonwealth Star (7 points, radius 756) sits at
/// (2520, 3780) and the Southern Cross is four 7-point stars of radius 360
/// and one 5-point of radius 210. Inner ratio 4/9 on all of them.
abstract final class AustraliaCountry {
  static const double _inner = 160 / 360;

  static const PlateDrawing _flag = PlateDrawing(10080, 5040, <PlateShape>[
    PlateRectShape(0, 0, 10080, 5040, AustraliaColors.flagBlue),
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(563.472, 0),
      Offset(5040, 2238.264),
      Offset(5040, 2520),
      Offset(4476.528, 2520),
      Offset(0, 281.736),
    ], AustraliaColors.white),
    PlatePolygonShape(<Offset>[
      Offset(0, 2520),
      Offset(563.472, 2520),
      Offset(5040, 281.736),
      Offset(5040, 0),
      Offset(4476.528, 0),
      Offset(0, 2238.264),
    ], AustraliaColors.white),
    PlatePolygonShape(<Offset>[
      Offset(2520, 1260),
      Offset(2895.648, 1260),
      Offset(5040, 2332.176),
      Offset(5040, 2520),
    ], AustraliaColors.flagRed),
    PlatePolygonShape(<Offset>[
      Offset(2520, 1260),
      Offset(2144.352, 1260),
      Offset(0, 187.824),
      Offset(0, 0),
    ], AustraliaColors.flagRed),
    PlatePolygonShape(<Offset>[
      Offset(2520, 1260),
      Offset(2520, 1447.824),
      Offset(375.648, 2520),
      Offset(0, 2520),
    ], AustraliaColors.flagRed),
    PlatePolygonShape(<Offset>[
      Offset(2520, 1260),
      Offset(2520, 1072.176),
      Offset(4664.352, 0),
      Offset(5040, 0),
    ], AustraliaColors.flagRed),
    PlateRectShape(2100, 0, 840, 2520, AustraliaColors.white),
    PlateRectShape(0, 840, 5040, 840, AustraliaColors.white),
    PlateRectShape(2268, 0, 504, 2520, AustraliaColors.flagRed),
    PlateRectShape(0, 1008, 5040, 504, AustraliaColors.flagRed),
    PlateStarShape(
      2520,
      3780,
      756,
      AustraliaColors.white,
      points: 7,
      innerRatio: _inner,
    ),
    PlateStarShape(
      7560,
      4200,
      360,
      AustraliaColors.white,
      points: 7,
      innerRatio: _inner,
    ),
    PlateStarShape(
      6300,
      2205,
      360,
      AustraliaColors.white,
      points: 7,
      innerRatio: _inner,
    ),
    PlateStarShape(
      7560,
      840,
      360,
      AustraliaColors.white,
      points: 7,
      innerRatio: _inner,
    ),
    PlateStarShape(
      8680,
      1869,
      360,
      AustraliaColors.white,
      points: 7,
      innerRatio: _inner,
    ),
    PlateStarShape(8064, 2730, 210, AustraliaColors.white, innerRatio: _inner),
  ]);

  static const PlateCountry australia = PlateCountry(
    code: 'au',
    panelColor: AustraliaColors.flagBlue,
    panelTextColor: AustraliaColors.white,
    flagAspectRatio: 2,
    flag: _flag,
  );
}
