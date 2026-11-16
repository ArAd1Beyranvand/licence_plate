import 'package:license_plate/core/plate_core.dart';

/// Cyprus as a `PlateCountry`: the EU band. The stars are
/// `EuropeanStars.band`; the `CY` beneath them is a `PlateLabel` on the spec,
/// so [captionLines] is empty.
abstract final class CyprusCountry {
  static const PlateCountry cyprus = PlateCountry.euroband(code: 'cy');
}
