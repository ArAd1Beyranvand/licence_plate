import 'package:license_plate/core/plate_core.dart';

import 'jersey_colors.dart';

/// The front plate's left strip: `JERSEY` over the arms over `GBJ`
/// (Great Britain and Northern Ireland – Jersey). The rear plate has none.
///
/// The arms are kept as an SVG: three leopards on a shield are a crest, not
/// something shapes can draw. Wikimedia Commons, `Coat_of_arms_of_Jersey.svg`
/// (https://commons.wikimedia.org/wiki/File:Coat_of_arms_of_Jersey.svg).
abstract final class JerseyCountry {
  static const PlateCountry front = PlateCountry(
    code: 'je',
    headingLines: <String>['JERSEY'],
    captionLines: <String>['GBJ'],
    panelColor: JerseyColors.silver,
    panelTextColor: JerseyColors.slate,
    flagAspectRatio: 197.92 / 237.32,
    flag: SvgPlateAsset(
      'assets/countries/united_kingdom/jersey/icons/coat_of_arms_of_jersey.svg',
      package: 'license_plate',
    ),
  );

  /// The rear plate: no strip.
  static const PlateCountry jersey = PlateCountry(
    code: 'je-rear',
    captionLines: <String>['J'],
    panelColor: JerseyColors.rearYellow,
    panelTextColor: JerseyColors.rearInk,
  );
}
