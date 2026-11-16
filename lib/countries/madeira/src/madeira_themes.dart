import 'package:license_plate/core/plate_core.dart';
import 'package:license_plate/countries/portugal/portugal_plate.dart';

/// The Portuguese themes; there is no Madeiran livery.
abstract final class MadeiraThemes {
  static final PlateTheme private = PortugalThemes.private;
  static final PlateTheme diplomatic = PortugalThemes.diplomatic;
  static final PlateTheme historic = PortugalThemes.historic;
}
