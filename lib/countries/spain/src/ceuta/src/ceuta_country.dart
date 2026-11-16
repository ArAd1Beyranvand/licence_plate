import 'package:license_plate/core/plate_core.dart';

import 'ceuta_colors.dart';

/// Ceuta as a `PlateCountry`: the EU band every Spanish plate of the current
/// series carries. The `E` beneath the stars is a [PlateLabel] on the spec, so
/// [captionLines] is empty. `ea` is the code ISO 3166-1 reserves for Ceuta and
/// Melilla.
abstract final class CeutaCountry {
  static const PlateCountry ceuta = PlateCountry.euroband(
    code: 'ea',
    panelColor: CeutaColors.euroBlue,
    panelTextColor: CeutaColors.white,
  );
}
