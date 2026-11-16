import 'package:flutter/widgets.dart';

/// The colours of the Micronesian plates, sampled from pixels of the flattened
/// references in `.plateref/fm`. Pohnpei and Kosrae are clean graphics, so
/// theirs are exact; Yap is a photograph, white-balanced, so treat it as close.
abstract final class FederatedStatesOfMicronesiaColors {
  /// Pohnpei field. `Micronesia_Pohnpei_license_plate_graphic`: `477C3F`.
  static const Color pohnpeiField = Color(0xFF477C3F);
  static const Color pohnpeiInk = Color(0xFFFFFFFF);

  /// Yap field. `Yap_license_plate_2000_series`: `C3C3C1`.
  static const Color yapField = Color(0xFFC3C3C1);

  /// Its ink, same photo: `151516`.
  static const Color yapInk = Color(0xFF151516);

  /// Kosrae field. `Micronesia_Kosrae_license_plate_graphic`: `E5E5E5`.
  static const Color kosraeField = Color(0xFFE5E5E5);

  /// Its ink, same graphic: `00007E`.
  static const Color kosraeInk = Color(0xFF00007E);
}
