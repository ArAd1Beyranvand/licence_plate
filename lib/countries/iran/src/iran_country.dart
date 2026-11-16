import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'iran_colors.dart';

abstract final class IranCountry {
  static const PlateCountry iran = PlateCountry(
    code: 'ir',
    captionLines: ['I.R.', 'IRAN'],
    panelColor: IranColors.panelBlue,
    panelTextColor: Color(0xFFFFFFFF),
    flagAspectRatio: 7 / 4,
    flag: SvgPlateAsset(
      'assets/countries/iran/flags/Flag_of_Iran.svg',
      package: 'license_plate',
    ),
  );
}
