import 'package:license_plate/core/plate_core.dart';

import 'sweden_colors.dart';

/// The EU band. The stars are the shared European flag asset; the `S` beneath
/// is a [PlateLabel] on the spec, so [captionLines] is empty. Plates without
/// the band set `noPanel`.
abstract final class SwedenCountry {
  static const PlateCountry sweden = PlateCountry.euroband(
    code: 'se',
    panelColor: SwedenColors.euroBlue,
  );
}
