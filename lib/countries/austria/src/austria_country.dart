import 'package:license_plate/core/plate_core.dart';

/// Austria as a `PlateCountry`: the EU band with `EuropeanStars.band`. The
/// `A` beneath the stars is a [PlateLabel] on the spec, so [captionLines] is
/// empty. Plates without a band (export, temporary, moped) set `noPanel`.
abstract final class AustriaCountry {
  static const PlateCountry austria = PlateCountry.euroband(code: 'at');
}
