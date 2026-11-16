import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'morocco_colors.dart';

/// Every plate prints its own colours and none has a country block, so specs
/// set `noPanel`; the flag is carried for hosts that list countries and as the
/// drawing the military plates reuse for their star.
abstract final class MoroccoCountry {
  /// `Flag_of_Morocco.svg`: 900x600, red field, green pentagram drawn as a
  /// 14.26-wide line (five rectangles along the star's strokes, centred on
  /// (450, 300) with a circumradius of 126.9).
  static const PlateDrawing _flag = PlateDrawing(900, 600, <PlateShape>[
    PlateRectShape(0, 0, 900, 600, MoroccoColors.flagRed),
    PlatePolygonShape(<Offset>[
      Offset(441.0, 168.5),
      Offset(520.0, 411.7),
      Offset(533.6, 407.3),
      Offset(454.6, 164.1),
    ], MoroccoColors.flagGreen),
    PlatePolygonShape(<Offset>[
      Offset(534.6, 401.1),
      Offset(327.7, 250.8),
      Offset(319.3, 262.4),
      Offset(526.2, 412.6),
    ], MoroccoColors.flagGreen),
    PlatePolygonShape(<Offset>[
      Offset(322.2, 267.9),
      Offset(577.8, 267.9),
      Offset(577.8, 253.6),
      Offset(322.2, 253.6),
    ], MoroccoColors.flagGreen),
    PlatePolygonShape(<Offset>[
      Offset(572.3, 250.8),
      Offset(365.4, 401.1),
      Offset(373.8, 412.6),
      Offset(580.7, 262.4),
    ], MoroccoColors.flagGreen),
    PlatePolygonShape(<Offset>[
      Offset(380.0, 411.7),
      Offset(459.0, 168.5),
      Offset(445.4, 164.1),
      Offset(366.4, 407.3),
    ], MoroccoColors.flagGreen),
  ]);

  static const PlateCountry morocco = PlateCountry(
    code: 'ma',
    panelColor: MoroccoColors.flagRed,
    panelTextColor: MoroccoColors.white,
    flagAspectRatio: 3 / 2,
    flag: _flag,
  );
}
