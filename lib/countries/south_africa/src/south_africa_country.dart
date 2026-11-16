import 'package:license_plate/core/plate_core.dart';

import 'south_africa_colors.dart';

/// South Africa as a `PlateCountry`. No plate prints a flag or a country
/// strip — the provincial emblems, landscapes and coats of arms (Eastern Cape
/// elephant, Free State cheetah, Gauteng crest ...) are artwork, not drawn
/// here — so every spec sets `noPanel`. The flag on the source page is not
/// plate content.
abstract final class SouthAfricaCountry {
  static const PlateCountry south_africa = PlateCountry(
    code: 'za',
    captionLines: <String>['ZA'],
    panelColor: SouthAfricaColors.white,
    panelTextColor: SouthAfricaColors.black,
  );
}
