import 'package:license_plate/core/plate_core.dart';

import 'ivory_coast_colors.dart';

/// Ivory Coast as a `PlateCountry`. No plate prints a side panel from it: the
/// strip is part of each spec's background, and only the military plate shows
/// the flag, as a decal.
abstract final class IvoryCoastCountry {
  // https://commons.wikimedia.org/wiki/File:Flag_of_C%C3%B4te_d%27Ivoire.svg
  static const PlateDrawing flag = PlateDrawing(900, 600, <PlateShape>[
    PlateRectShape(0, 0, 900, 600, IvoryCoastColors.flagGreen),
    PlateRectShape(0, 0, 600, 600, IvoryCoastColors.white),
    PlateRectShape(0, 0, 300, 600, IvoryCoastColors.flagOrange),
  ]);

  static const PlateCountry ivory_coast = PlateCountry(
    code: 'ci',
    captionLines: <String>['CI'],
    panelColor: IvoryCoastColors.orange,
    panelTextColor: IvoryCoastColors.white,
    flagAspectRatio: 3 / 2,
    flag: flag,
  );
}
