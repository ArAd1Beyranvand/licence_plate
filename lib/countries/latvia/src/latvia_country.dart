import 'package:license_plate/core/plate_core.dart';

import 'latvia_colors.dart';

/// The EU panel (stars over `LV`).
abstract final class LatviaCountry {
  static const PlateCountry latvia = PlateCountry(
    code: 'lv',
    captionLines: <String>['LV'],
    panelColor: LatviaColors.euBlue,
    panelTextColor: LatviaColors.euInk,
    flagAspectRatio: 3 / 2,
    flag: EuropeanStars.flag,
  );
}
