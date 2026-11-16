import 'package:license_plate/core/plate_core.dart';

import 'belgium_colors.dart';

/// Belgium as a `PlateCountry`: the Euroband. The stars are
/// `EuropeanStars.band`; the `B` beneath them is a [PlateLabel] on the spec,
/// so [captionLines] is empty. The national tricolour is printed only on the
/// military plate, as a decal there.
abstract final class BelgiumCountry {
  static const PlateCountry belgium = PlateCountry.euroband(
    code: 'be',
    panelColor: BelgiumColors.euroBlue,
  );
}
