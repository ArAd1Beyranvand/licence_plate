import 'package:license_plate/core/plate_core.dart';

import 'togo_colors.dart';

/// Togo as a `PlateCountry`: the flag over `TG` at the left of the face. The
/// block has no fill of its own, so it sits on the plate's field.
abstract final class TogoCountry {
  static const PlateDrawing _flag = PlateDrawing(750, 500, <PlateShape>[
    PlateRectShape(0, 0, 750, 500, TogoColors.flagGreen),
    PlateRectShape(0, 100, 750, 100, TogoColors.flagYellow),
    PlateRectShape(0, 300, 750, 100, TogoColors.flagYellow),
    PlateRectShape(0, 0, 280, 350, TogoColors.flagRed),
    PlateStarShape(140, 150, 100, TogoColors.flagWhite),
  ]);

  static const PlateCountry togo = PlateCountry(
    code: 'tg',
    captionLines: <String>['TG'],
    panelColor: TogoColors.white,
    panelTextColor: TogoColors.black,
    flagAspectRatio: 3 / 2,
    // https://commons.wikimedia.org/wiki/File:Flag_of_Togo.svg
    flag: _flag,
  );
}
