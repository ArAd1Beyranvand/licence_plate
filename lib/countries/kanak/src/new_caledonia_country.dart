import 'package:license_plate/core/plate_core.dart';

import 'new_caledonia_colors.dart';

abstract final class NewCaledoniaCountry {
  /// The plate carries no flag or country block; the `NC` is part of the serial.
  // ignore: constant_identifier_names
  static const PlateCountry new_caledonia = PlateCountry(
    code: 'nc',
    captionLines: <String>['NC'],
    panelColor: NewCaledoniaColors.white,
    panelTextColor: NewCaledoniaColors.black,
    flagAspectRatio: 3 / 2,
  );
}
