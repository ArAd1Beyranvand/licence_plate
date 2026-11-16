import 'package:license_plate/core/plate_core.dart';

import 'estonia_colors.dart';

/// The EU panel (stars over `EST`). The diplomatic plate's panel is a darker
/// blue than its field, so it has its own constant.
abstract final class EstoniaCountry {
  static const PlateCountry estonia = PlateCountry(
    code: 'ee',
    captionLines: <String>['EST'],
    panelColor: EstoniaColors.euBlue,
    panelTextColor: EstoniaColors.euInk,
    flagAspectRatio: 3 / 2,
    flag: EuropeanStars.flag,
  );

  static const PlateCountry diplomatic = PlateCountry(
    code: 'ee',
    captionLines: <String>['EST'],
    panelColor: EstoniaColors.diplomaticPanel,
    panelTextColor: EstoniaColors.diplomaticInk,
    flagAspectRatio: 3 / 2,
    flag: EuropeanStars.flag,
  );
}
