import 'package:license_plate/core/plate_core.dart';

import 'spain_colors.dart';

/// Spain as a `PlateCountry`: the EU band. The `E` beneath the stars is a
/// [PlateLabel] on the spec, so [captionLines] is empty.
abstract final class SpainCountry {
  static const PlateCountry spain = PlateCountry.euroband(
    code: 'es',
    panelColor: SpainColors.euroBlue,
  );
}
