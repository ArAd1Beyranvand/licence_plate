import 'package:license_plate/core/plate_core.dart';

import 'albania_colors.dart';

/// Albania as a `PlateCountry`: the blue strip with the white double-headed
/// eagle above `AL`.
///
/// The eagle is a coat-of-arms, too complex to draw from shapes, so it is the
/// eagle path of Wikimedia Commons `Flag_of_Albania.svg` (public domain),
/// cropped to its bounds (viewBox `207 97 286 306`, aspect 286/306) and filled
/// white. It matches the plate's eagle in outline and proportion.
abstract final class AlbaniaCountry {
  static const PlateCountry albania = PlateCountry(
    code: 'al',
    captionLines: <String>['AL'],
    panelColor: AlbaniaColors.blue,
    panelTextColor: AlbaniaColors.white,
    flagAspectRatio: 286 / 306,
    flag: SvgPlateAsset('assets/countries/albania/albania_eagle.svg', package: 'license_plate'),
  );
}
