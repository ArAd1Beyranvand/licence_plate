import 'package:flutter/widgets.dart';

/// Sampled from one colour-balanced photo (`.plateref/ls`), so no spread is
/// known.
abstract final class LesothoColors {
  static const Color white = Color(0xFFE0DAD2);

  /// Characters, frame and the sticker's print.
  static const Color blue = Color(0xFF086BAF);

  /// Estimated from the photo, not sampled in isolation.
  static const Color sticker = Color(0xFFEDEAE4);
}
