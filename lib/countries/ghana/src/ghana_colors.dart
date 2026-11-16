import 'package:flutter/widgets.dart';

/// Sampled from the flattened reference plates and the official flag.
abstract final class GhanaColors {
  /// Field of the private plate.
  static const Color white = Color(0xFFE1E0E0);

  /// Field of the commercial plates, balanced on the old two-row photo.
  static const Color yellow = Color(0xFFFBC642);

  /// Field of the motorcycle plate, median of the blue pixels in the photo.
  static const Color blue = Color(0xFF0667DC);

  /// Ink and frame of the white and yellow plates.
  static const Color black = Color(0xFF151515);

  /// Ink and frame of the motorcycle plate.
  static const Color ink = Color(0xFFFEFEFE);

  static const Color flagRed = Color(0xFFCE1126);
  static const Color flagGold = Color(0xFFFCD116);
  static const Color flagGreen = Color(0xFF006B3F);
  static const Color flagStar = Color(0xFF000000);
}
