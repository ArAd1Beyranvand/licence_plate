import 'package:license_plate/core/plate_core.dart';

import 'federated_states_of_micronesia_colors.dart';

/// Micronesia as a `PlateCountry`. The plates carry no flag or country block,
/// only state names as labels, so every spec sets `noPanel`.
abstract final class FederatedStatesOfMicronesiaCountry {
  // ignore: constant_identifier_names
  static const PlateCountry federated_states_of_micronesia = PlateCountry(
    code: 'fm',
    panelColor: FederatedStatesOfMicronesiaColors.yapField,
    panelTextColor: FederatedStatesOfMicronesiaColors.yapInk,
  );
}
