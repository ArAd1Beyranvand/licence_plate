import 'package:license_plate/core/plate_core.dart';

import 'kyrgyzstan_colors.dart';

/// There is no country panel: the flag and `KG` are drawn by the spec.
abstract final class KyrgyzstanCountry {
  static const PlateCountry kyrgyzstan = PlateCountry(
    code: 'kg',
    panelColor: KyrgyzstanColors.flagRed,
    panelTextColor: KyrgyzstanColors.white,
  );
}
