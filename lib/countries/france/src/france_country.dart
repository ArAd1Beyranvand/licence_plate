import 'package:license_plate/core/plate_core.dart';

/// France as a `PlateCountry`: the EU band, whose stars are
/// `EuropeanStars.band`. The `F` beneath them is a [PlateLabel] on the spec,
/// so [captionLines] is empty.
abstract final class FranceCountry {
  static const PlateCountry france = PlateCountry.euroband(code: 'fr');
}
