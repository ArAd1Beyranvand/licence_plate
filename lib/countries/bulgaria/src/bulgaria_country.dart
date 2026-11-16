import 'package:license_plate/core/plate_core.dart';

import 'bulgaria_colors.dart';

/// Bulgaria as a `PlateCountry`, with the two bands the plates carry. The
/// `BG` beneath either is a [PlateLabel] on the spec, so `captionLines` is
/// empty.
abstract final class BulgariaCountry {
  /// The EU band: the shared ring of twelve stars on blue.
  static const PlateCountry bulgaria = PlateCountry.euroband(code: 'bg');

  /// The military and civil-protection band: the national tricolour (white,
  /// green, red; 5:3) on the same blue.
  static const PlateCountry bulgariaFlag = PlateCountry(
    code: 'bg',
    panelColor: BulgariaColors.euroBlue,
    panelTextColor: BulgariaColors.white,
    flagAspectRatio: 5 / 3,
    // https://commons.wikimedia.org/wiki/File:Flag_of_Bulgaria.svg
    flag: PlateDrawing(900, 540, <PlateShape>[
      PlateRectShape(0, 0, 900, 180, BulgariaColors.white),
      PlateRectShape(0, 180, 900, 180, BulgariaColors.flagGreen),
      PlateRectShape(0, 360, 900, 180, BulgariaColors.flagRed),
    ]),
  );
}
