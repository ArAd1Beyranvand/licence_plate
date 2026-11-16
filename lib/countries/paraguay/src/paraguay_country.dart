import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'paraguay_colors.dart';

/// Paraguay as a `PlateCountry`: no side panel. `PARAGUAY` is a [PlateLabel]
/// in the band and the flag a decal on each spec, so [captionLines] is empty.
///
/// The flag is the red, white and blue tricolour, 5:3. The national emblem on
/// the obverse is not drawn: a crest, and too small on the plate to read.
abstract final class ParaguayCountry {
  static const PlateDrawing flag = PlateDrawing(1000, 600, <PlateShape>[
    PlateRectShape(0, 0, 1000, 200, ParaguayColors.flagRed),
    PlateRectShape(0, 200, 1000, 200, Color(0xFFFFFFFF)),
    PlateRectShape(0, 400, 1000, 200, ParaguayColors.flagBlue),
  ]);

  static const PlateCountry paraguay = PlateCountry(
    code: 'py',
    panelColor: ParaguayColors.band,
    panelTextColor: ParaguayColors.bandText,
    flagAspectRatio: 5 / 3,
    flag: flag,
  );
}
