import 'package:license_plate/core/plate_core.dart';

import 'barbados_colors.dart';

/// The plates have no band, flag or caption, so only the code is meaningful.
abstract final class BarbadosCountry {
  static const PlateCountry barbados = PlateCountry(
    code: 'bb',
    panelColor: BarbadosColors.blackField,
    panelTextColor: BarbadosColors.silverInk,
  );
}
