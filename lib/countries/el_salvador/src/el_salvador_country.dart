import 'package:license_plate/core/plate_core.dart';

import 'el_salvador_colors.dart';

/// El Salvador as a `PlateCountry`. The 1976 plates carry no country block (the
/// name is printed text), so every spec sets `noPanel`.
abstract final class ElSalvadorCountry {
  // ignore: constant_identifier_names
  static const PlateCountry el_salvador = PlateCountry(
    code: 'sv',
    panelColor: ElSalvadorColors.tan,
    panelTextColor: ElSalvadorColors.ink,
  );
}
