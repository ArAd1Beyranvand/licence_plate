import 'package:license_plate/core/plate_core.dart';

import 'canary_islands_colors.dart';

/// The Canary Islands as a `PlateCountry`: the EU band every Spanish plate of
/// the current series carries. The `E` beneath the stars is a [PlateLabel] on
/// the spec, so [captionLines] is empty. `ic` is the code ISO 3166-1 reserves
/// for the Canary Islands.
abstract final class CanaryIslandsCountry {
  static const PlateCountry canary_islands = PlateCountry.euroband(
    code: 'ic',
    panelColor: CanaryIslandsColors.euroBlue,
  );
}
