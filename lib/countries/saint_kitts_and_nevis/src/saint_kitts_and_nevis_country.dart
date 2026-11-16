import 'package:license_plate/core/plate_core.dart';

import 'saint_kitts_and_nevis_colors.dart';

/// The plates carry no band or flag, so only the code is meaningful.
abstract final class SaintKittsAndNevisCountry {
  static const PlateCountry saint_kitts_and_nevis = PlateCountry(
    code: 'kn',
    panelColor: SaintKittsAndNevisColors.blackField,
    panelTextColor: SaintKittsAndNevisColors.creamInk,
  );
}
