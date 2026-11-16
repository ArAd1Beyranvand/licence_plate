import 'package:license_plate/core/plate_core.dart';

import 'guernsey_colors.dart';

/// Neither island's plate prints a flag or a strip. The optional GBG oval the
/// article mentions is not implemented.
abstract final class GuernseyCountry {
  static const PlateCountry guernsey = PlateCountry(
    code: 'gg',
    captionLines: <String>['GBG'],
    panelColor: GuernseyColors.white,
    panelTextColor: GuernseyColors.black,
  );

  static const PlateCountry alderney = PlateCountry(
    code: 'gg-aly',
    captionLines: <String>['AY'],
    panelColor: GuernseyColors.alderneyYellow,
    panelTextColor: GuernseyColors.alderneyInk,
  );
}
