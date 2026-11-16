import 'package:license_plate/core/plate_core.dart';

/// The EU band. The `P` (`U` on the US Forces plates) beneath the stars is a
/// [PlateLabel] on the spec, so [captionLines] is empty. Plates with no band
/// set `noPanel`.
abstract final class PortugalCountry {
  static const PlateCountry portugal = PlateCountry.euroband(code: 'pt');
}
