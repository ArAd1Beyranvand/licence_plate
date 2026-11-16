import 'package:flutter/widgets.dart';

/// Sampled from the flattened reference plates.
abstract final class TogoColors {
  /// Field of the regular plate.
  static const Color white = Color(0xFFFFFFFF);

  /// Ink and frame of the regular plate.
  static const Color blue = Color(0xFF00137F);

  /// Field of the commercial plate.
  static const Color yellow = Color(0xFFFFD800);

  /// Ink and frame of the commercial plate.
  static const Color red = Color(0xFFFE0000);

  /// The printed dot between the number and the series.
  static const Color dot = Color(0xFF808080);

  /// The `TG` caption under the flag.
  static const Color black = Color(0xFF000000);

  /// The flag (Flag_of_Togo.svg).
  static const Color flagGreen = Color(0xFF006A4E);
  static const Color flagYellow = Color(0xFFFFCE00);
  static const Color flagRed = Color(0xFFD21034);
  static const Color flagWhite = Color(0xFFFFFFFF);
}
