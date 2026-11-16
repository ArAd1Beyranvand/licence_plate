import 'package:license_plate/core/plate_core.dart';

import 'finland_colors.dart';

/// The EU panel (flag over `FIN`) used by regular, motorcycle and export
/// plates. Diplomatic and Åland plates carry none and set `noPanel`.
abstract final class FinlandCountry {
  static const PlateCountry finland = PlateCountry(
    code: 'fi',
    captionLines: <String>['FIN'],
    panelColor: FinlandColors.euBlue,
    panelTextColor: FinlandColors.euInk,
    flagAspectRatio: 3 / 2,
    flag: EuropeanStars.flag,
  );
}
