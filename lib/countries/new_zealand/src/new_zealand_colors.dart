import 'package:flutter/widgets.dart';

/// Colours sampled from the flattened, colour-balanced reference photos.
///
/// [white]/[black] come from the standard plate photo, [darkField]/[silver]
/// from the old plate photo, [blue]/[europlateField]/[europlateInk] from the
/// Europlate photo's bands, face and characters.
abstract final class NewZealandColors {
  /// Standard plate field, `D6D0C4`.
  static const Color white = Color(0xFFD6D0C4);

  /// Standard plate characters, `251B25`.
  static const Color black = Color(0xFF251B25);

  /// Europlate field, `D2D4CE`.
  static const Color europlateField = Color(0xFFD2D4CE);

  /// Europlate characters, `080000` (darkest mode).
  static const Color europlateInk = Color(0xFF0A0808);

  /// Europlate side bands, `0030B0`.
  static const Color blue = Color(0xFF0030B0);

  /// Old plate field, `222F38`.
  static const Color darkField = Color(0xFF222F38);

  /// Old plate characters, `F3F5F7`.
  static const Color silver = Color(0xFFF3F5F7);
}
