import 'package:license_plate/core/plate_core.dart';

import 'bangladesh_colors.dart';

/// Bangladesh as a `PlateCountry`. The plates print no flag or country strip,
/// so specs set `noPanel` and only the code is used.
abstract final class BangladeshCountry {
  static const PlateCountry bangladesh = PlateCountry(
    code: 'bd',
    captionLines: <String>['BD'],
    panelColor: BangladeshColors.white,
    panelTextColor: BangladeshColors.black,
  );
}
