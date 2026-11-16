// ignore_for_file: constant_identifier_names
import 'package:license_plate/core/plate_core.dart';

import 'saint_helena_colors.dart';

/// Plates carry no flag or band; the country only names the territory.
abstract final class SaintHelenaCountry {
  static const PlateCountry saint_helena = PlateCountry(
    code: 'sh',
    captionLines: <String>['SAINT HELENA'],
    panelColor: SaintHelenaColors.rearYellow,
    panelTextColor: SaintHelenaColors.black,
  );
}
