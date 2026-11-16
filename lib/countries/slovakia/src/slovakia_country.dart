import 'package:license_plate/core/plate_core.dart';

import 'slovakia_colors.dart';

/// The `SK` beneath the EU band is a [PlateLabel] on each spec, so
/// [PlateCountry.captionLines] is empty. The diplomatic plate paints the band
/// in its own blue.
abstract final class SlovakiaCountry {
  static const PlateCountry slovakia = PlateCountry.euroband(
    code: 'sk',
    panelColor: SlovakiaColors.euroBlue,
    panelTextColor: SlovakiaColors.white,
  );

  static const PlateCountry diplomatic = PlateCountry.euroband(
    code: 'sk',
    panelColor: SlovakiaColors.diplomaticBlue,
    panelTextColor: SlovakiaColors.white,
  );
}
