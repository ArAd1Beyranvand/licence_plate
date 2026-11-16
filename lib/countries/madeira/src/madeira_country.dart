import 'package:license_plate/core/plate_core.dart';
import 'package:license_plate/countries/portugal/portugal_plate.dart';

/// Madeira's plates carry the Portuguese `P` on the EU band.
abstract final class MadeiraCountry {
  static const PlateCountry madeira = PortugalCountry.portugal;
}
