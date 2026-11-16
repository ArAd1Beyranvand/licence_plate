import 'package:license_plate/core/plate_core.dart';

import 'hong_kong_colors.dart';

abstract final class HongKongCountry {
  // ignore: constant_identifier_names
  /// Hong Kong plates carry no flag or country block.
  static const PlateCountry hong_kong = PlateCountry(
    code: 'hk',
    captionLines: <String>['HK'],
    panelColor: HongKongColors.white,
    panelTextColor: HongKongColors.black,
    flagAspectRatio: 3 / 2,
  );
}
