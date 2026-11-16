import 'package:license_plate/core/plate_core.dart';

import 'falkland_islands_colors.dart';

abstract final class FalklandIslandsCountry {
  /// The plates carry no flag or country block.
  // ignore: constant_identifier_names
  static const PlateCountry falkland_islands = PlateCountry(
    code: 'fk',
    captionLines: <String>['FK'],
    panelColor: FalklandIslandsColors.white,
    panelTextColor: FalklandIslandsColors.black,
    flagAspectRatio: 3 / 2,
  );
}
