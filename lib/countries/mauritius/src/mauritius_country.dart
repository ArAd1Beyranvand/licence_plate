import 'package:license_plate/core/plate_core.dart';

import 'mauritius_colors.dart';

/// Mauritius as a `PlateCountry`. The plate carries no country block, so the
/// spec sets `noPanel`.
abstract final class MauritiusCountry {
  static const PlateCountry mauritius = PlateCountry(
    code: 'mu',
    panelColor: MauritiusColors.black,
    panelTextColor: MauritiusColors.silver,
  );
}
