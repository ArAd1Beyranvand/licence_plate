import 'package:license_plate/core/plate_core.dart';

import 'mexico_colors.dart';

/// Mexico as a `PlateCountry`. No plate prints a country block, so every spec
/// sets `noPanel`; this carries the flag for hosts that list countries.
///
/// The flag is an SVG, not a `PlateDrawing`: the coat of arms (an eagle on a
/// cactus devouring a serpent) is far past what the shape vocabulary draws.
/// `assets/icons/flag_of_mexico.svg` is `Flag_of_Mexico.svg` from Wikimedia
/// Commons (public domain), unminified (no minifier available).
abstract final class MexicoCountry {
  static const PlateCountry mexico = PlateCountry(
    code: 'mx',
    panelColor: MexicoColors.flagGreen,
    panelTextColor: MexicoColors.white,
    flagAspectRatio: 7 / 4,
    flag: SvgPlateAsset(
      'assets/countries/mexico/icons/flag_of_mexico.svg',
      package: 'license_plate',
    ),
  );
}
