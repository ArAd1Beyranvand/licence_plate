import 'package:license_plate/core/plate_core.dart';

import 'belize_colors.dart';

/// Belize as a `PlateCountry`. No Belizean plate prints a country block (the
/// caption "BELIZE C.A." is plain lettering), so every spec sets `noPanel`;
/// this carries the flag for hosts that list countries.
abstract final class BelizeCountry {
  static const PlateCountry belize = PlateCountry(
    code: 'bz',
    panelColor: BelizeColors.flagBlue,
    panelTextColor: BelizeColors.white,
    flagAspectRatio: 5 / 3,
    // Flag_of_Belize.svg, Wikimedia Commons (page SVG of the article).
    flag: SvgPlateAsset(
      'assets/countries/belize/flags/Flag_of_Belize.svg',
      package: 'license_plate',
    ),
  );
}
