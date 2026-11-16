import 'package:license_plate/core/plate_core.dart';

import 'croatia_colors.dart';

/// Croatia as a `PlateCountry`: the EU band. The twelve stars are the shared
/// `EuropeanStars.band`; the `HR` beneath them is a [PlateLabel] on the spec,
/// so [captionLines] is empty. Plates without a band set `noPanel`.
abstract final class CroatiaCountry {
  static const PlateCountry croatia = PlateCountry.euroband(
    code: 'hr',
    panelColor: CroatiaColors.euroBlue,
  );
}
