import 'package:license_plate/core/plate_core.dart';

import 'luxembourg_colors.dart';

/// Luxembourg as a `PlateCountry`: the EU band. The `L` under the stars is a
/// [PlateLabel] on the spec, so [captionLines] is empty.
abstract final class LuxembourgCountry {
  static const PlateCountry luxembourg = PlateCountry.euroband(
    code: 'lu',
    panelColor: LuxembourgColors.euroBlue,
  );
}
