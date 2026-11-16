import 'package:license_plate/core/plate_core.dart';

import 'montenegro_colors.dart';

/// Montenegro as a `PlateCountry`: only the blue side band. `MNE` is a
/// [PlateLabel] on each spec, so [captionLines] is empty and there is no flag.
abstract final class MontenegroCountry {
  static const PlateCountry montenegro = PlateCountry(
    code: 'me',
    panelColor: MontenegroColors.band,
    panelTextColor: MontenegroColors.white,
  );
}
