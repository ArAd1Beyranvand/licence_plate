import 'package:flutter/widgets.dart';

/// The colours of the Burundian plates.
///
/// The photographs are too small and too dim to sample (the rear plate reads
/// orange in shadow), so the field colours follow the article — "yellow or
/// white depending if it is the rear or front plate" — and are nominal, not
/// sampled.
abstract final class BurundiColors {
  static const Color white = Color(0xFFFFFFFF);

  /// Rear field: nominal.
  static const Color yellow = Color(0xFFFFD100);

  static const Color black = Color(0xFF000000);

  /// National flag: red `CE1126`, green `1EB53A` (the official values).
  static const Color flagRed = Color(0xFFCE1126);
  static const Color flagGreen = Color(0xFF1EB53A);
}
