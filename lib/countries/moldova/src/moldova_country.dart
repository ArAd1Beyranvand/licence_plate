import 'package:license_plate/core/plate_core.dart';

import 'moldova_colors.dart';

/// The band's `MD` is a label on each spec, so [captionLines] is empty. The
/// flag carries the coat of arms, so it stays an SVG
/// (`Flag_of_Moldova.svg`, Wikimedia Commons).
abstract final class MoldovaCountry {
  static const PlateCountry moldova = PlateCountry(
    code: 'md',
    panelColor: MoldovaColors.bandBlue,
    panelTextColor: MoldovaColors.white,
    flagAspectRatio: 62.5 / 33.5,
    flag: SvgPlateAsset(
      'assets/countries/moldova/flags/Flag_of_Moldova.svg',
      package: 'license_plate',
    ),
  );
}
