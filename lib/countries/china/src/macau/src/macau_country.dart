import 'package:license_plate/core/plate_core.dart';

import 'macau_colors.dart';

abstract final class MacauCountry {
  /// Macau plates carry no flag or country block.
  static const PlateCountry macau = PlateCountry(
    code: 'mo',
    captionLines: <String>['MO'],
    panelColor: MacauColors.black,
    panelTextColor: MacauColors.white,
    flagAspectRatio: 3 / 2,
  );
}
