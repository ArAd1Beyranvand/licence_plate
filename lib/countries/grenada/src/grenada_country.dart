import 'package:license_plate/core/plate_core.dart';

import 'grenada_colors.dart';

/// Grenada as a `PlateCountry`. The plates print no strip or flag.
abstract final class GrenadaCountry {
  static const PlateCountry grenada = PlateCountry(
    code: 'gd',
    captionLines: <String>['WG'],
    panelColor: GrenadaColors.yellow,
    panelTextColor: GrenadaColors.black,
  );
}
