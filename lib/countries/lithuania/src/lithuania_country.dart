import 'package:license_plate/core/plate_core.dart';

import 'lithuania_colors.dart';

/// The EU panel (stars over `LT`). The 1993–2004 stripe with the national flag
/// is not implemented.
abstract final class LithuaniaCountry {
  static const PlateCountry lithuania = PlateCountry(
    code: 'lt',
    captionLines: <String>['LT'],
    panelColor: LithuaniaColors.euBlue,
    panelTextColor: LithuaniaColors.euInk,
    flagAspectRatio: 3 / 2,
    flag: EuropeanStars.flag,
  );
}
