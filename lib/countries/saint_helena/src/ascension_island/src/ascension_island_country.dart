import 'package:license_plate/core/plate_core.dart';

import 'ascension_island_colors.dart';

abstract final class AscensionIslandCountry {
  /// The plates carry no flag or country block.
  // ignore: constant_identifier_names
  static const PlateCountry ascension_island = PlateCountry(
    code: 'ac',
    captionLines: <String>['AC'],
    panelColor: AscensionIslandColors.white,
    panelTextColor: AscensionIslandColors.black,
    flagAspectRatio: 3 / 2,
  );
}
