import 'package:license_plate/core/plate_core.dart';

import 'guatemala_colors.dart';

/// Guatemala as a `PlateCountry`: no side panel and no flag. `GUATEMALA` and
/// `CENTRO AMÉRICA` are [PlateLabel]s on the spec, so [captionLines] is empty.
abstract final class GuatemalaCountry {
  static const PlateCountry guatemala = PlateCountry(
    code: 'gt',
    panelColor: GuatemalaColors.white,
    panelTextColor: GuatemalaColors.black,
  );
}
