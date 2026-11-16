import 'package:flutter/widgets.dart';

/// The colours of the current Tongan plate.
///
/// [field] and [ink] are sampled: the modal colours of the flattened
/// `Tonga_license_plate_graphic`. The article says "white on black".
abstract final class TongaColors {
  static const Color field = Color(0xFF050505);
  static const Color ink = Color(0xFFFFFFFF);
  static const Color inactive = Color(0xFF6B6B6B);

  /// Unsampled: the flag's red, from the construction in the Commons SVG
  /// (`#C10000`).
  static const Color flagRed = Color(0xFFC10000);
}
