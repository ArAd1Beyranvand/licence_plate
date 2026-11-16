import 'package:license_plate/core/plate_core.dart';

import 'dominican_republic_colors.dart';

/// The Dominican Republic as a `PlateCountry`. No plate prints a flag or a
/// country block: the name is lettered on the face, so every spec sets
/// `noPanel`.
abstract final class DominicanRepublicCountry {
  // The harness in test/golden_test.dart names this member.
  // ignore: constant_identifier_names
  static const PlateCountry dominican_republic = PlateCountry(
    code: 'do',
    panelColor: DominicanRepublicColors.white,
    panelTextColor: DominicanRepublicColors.black,
  );
}
