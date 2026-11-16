import 'package:license_plate/core/plate_core.dart';

import 'isle_of_man_colors.dart';

/// The red strip: the Manx flag over `GBM`. The flag is a triskelion with
/// dozens of curved paths, too complex to draw from shapes, so it stays an SVG
/// (Commons `Flag_of_the_Isle_of_Man.svg`, 600×300, minified). The strip's
/// colour is painted by the spec's background.
abstract final class IsleOfManCountry {
  // ignore: constant_identifier_names
  static const PlateCountry isle_of_man = PlateCountry(
    code: 'im',
    captionLines: <String>['GBM'],
    panelColor: IsleOfManColors.red,
    panelTextColor: IsleOfManColors.white,
    flagAspectRatio: 2,
    flag: SvgPlateAsset(
      'assets/countries/united_kingdom/isle_of_man/icons/flag_of_the_isle_of_man.svg',
      package: 'license_plate',
    ),
  );
}
