import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'federated_states_of_micronesia_colors.dart';

/// One ink on one field, the frame in the ink. The border width and corner
/// radius are not measured.
abstract final class FederatedStatesOfMicronesiaThemes {
  static final PlateTheme pohnpei = _ink(
    FederatedStatesOfMicronesiaColors.pohnpeiField,
    FederatedStatesOfMicronesiaColors.pohnpeiInk,
  );

  static final PlateTheme yap = _ink(
    FederatedStatesOfMicronesiaColors.yapField,
    FederatedStatesOfMicronesiaColors.yapInk,
  );

  static final PlateTheme kosrae = _ink(
    FederatedStatesOfMicronesiaColors.kosraeField,
    FederatedStatesOfMicronesiaColors.kosraeInk,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.02,
  plateRadiusRatio: 0.05,
);
