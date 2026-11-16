import 'package:license_plate/core/plate_core.dart';

import 'tristan_da_cunha_colors.dart';

abstract final class TristanDaCunhaCountry {
  /// The plates carry no flag or country block.
  // ignore: constant_identifier_names
  static const PlateCountry tristan_da_cunha = PlateCountry(
    code: 'td',
    captionLines: <String>['TDC'],
    panelColor: TristanDaCunhaColors.black,
    panelTextColor: TristanDaCunhaColors.white,
    flagAspectRatio: 3 / 2,
  );
}
