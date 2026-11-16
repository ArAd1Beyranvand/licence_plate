import 'package:license_plate/core/plate_core.dart';

import 'haiti_colors.dart';

/// Haiti as a `PlateCountry`. No plate prints a country block (the 2003 flag is
/// a small decal on the spec), so every spec sets `noPanel` and this carries
/// only the flag for hosts that list countries.
///
/// The flag keeps its SVG: the coat of arms on its white panel is a crest, not
/// something an algorithm draws. `assets/flags/Flag_of_Haiti.svg` is
/// `Flag_of_Haiti.svg` from Wikimedia Commons (public domain), stripped of
/// editor metadata.
abstract final class HaitiCountry {
  static const PlateCountry haiti = PlateCountry(
    code: 'ht',
    panelColor: HaitiColors.flagBlue,
    panelTextColor: HaitiColors.caption,
    flagAspectRatio: 5 / 3,
    flag: SvgPlateAsset(
      'assets/countries/haiti/flags/Flag_of_Haiti.svg',
      package: 'license_plate',
    ),
  );
}
