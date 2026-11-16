import 'package:license_plate/core/plate_core.dart';

import 'abkhazia_colors.dart';

/// The flag carries a hand and seven stars, so it stays an SVG.
/// Source: https://commons.wikimedia.org/wiki/File:Flag_of_the_Republic_of_Abkhazia.svg
abstract final class AbkhaziaCountry {
  static const PlateCountry abkhazia = PlateCountry(
    code: 'ab',
    captionLines: <String>['ABH'],
    panelColor: AbkhaziaColors.white,
    panelTextColor: AbkhaziaColors.black,
    flagAspectRatio: 2,
    flag: SvgPlateAsset(
      'assets/countries/russia/abkhazia/icons/abkhazia_flag.svg',
      package: 'license_plate',
    ),
  );
}
