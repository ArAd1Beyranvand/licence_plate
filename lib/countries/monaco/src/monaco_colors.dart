import 'package:flutter/widgets.dart';

/// The colours of the Monaco plates, modal pixels of the flattened reference
/// photos (`.plateref/mc/`). The article says "light blue" for both; the
/// motorcycle photo is lit violet-ish (`5468BC`), sampled as it is.
abstract final class MonacoColors {
  static const Color field = Color(0xFFE4E0DC);
  static const Color blue = Color(0xFF1064B8);

  static const Color fieldMotorcycle = Color(0xFFEEE8E3);
  static const Color blueMotorcycle = Color(0xFF5468BC);

  /// The lozenges of the arms.
  static const Color red = Color(0xFFD01C10);

  /// The block under the year on the rear badge, behind a white `MC`.
  static const Color badgeBlue = Color(0xFF042088);
  static const Color white = Color(0xFFFFFFFF);

  /// The flag's red, from the page's `Flag_of_Monaco.svg`.
  static const Color flagRed = Color(0xFFCE1126);
}
