import 'package:license_plate/core/plate_core.dart';

import 'northern_cyprus_colors.dart';

abstract final class NorthernCyprusCountry {
  /// The plate's strip carries a small emblem, not a flag; none is drawn.
  // ignore: constant_identifier_names
  static const PlateCountry northern_cyprus = PlateCountry(
    code: 'xn',
    captionLines: <String>['TRNC'],
    panelColor: NorthernCyprusColors.strip,
    panelTextColor: NorthernCyprusColors.white,
    flagAspectRatio: 3 / 2,
  );
}
