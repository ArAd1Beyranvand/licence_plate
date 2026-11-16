import 'package:license_plate/core/plate_core.dart';

import 'melilla_colors.dart';

/// Melilla as a `PlateCountry`: the EU band every Spanish plate of the current
/// series carries. The `E` beneath the stars is a [PlateLabel] on the spec, so
/// [captionLines] is empty. `ea` is the code ISO 3166-1 reserves for Melilla and
/// Melilla.
abstract final class MelillaCountry {
  static const PlateCountry melilla = PlateCountry.euroband(
    code: 'ea',
    panelColor: MelillaColors.euroBlue,
    panelTextColor: MelillaColors.white,
  );
}
