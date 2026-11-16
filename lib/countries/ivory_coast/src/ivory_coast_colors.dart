import 'package:flutter/widgets.dart';

/// Sampled from the flattened reference plates (the flag from the page SVG).
abstract final class IvoryCoastColors {
  /// Field of the private plate.
  static const Color blue = Color(0xFF003399);

  /// Field of the diplomatic plate and the strip of the private and temporary
  /// ones.
  static const Color orange = Color(0xFFF56505);

  /// Field of the temporary plate.
  static const Color green = Color(0xFF008040);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// The flag's own orange and green, from the official artwork.
  static const Color flagOrange = Color(0xFFFF8200);
  static const Color flagGreen = Color(0xFF009A44);
}
