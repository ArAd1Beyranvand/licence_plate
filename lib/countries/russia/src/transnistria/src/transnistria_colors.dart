import 'package:flutter/widgets.dart';

/// Modal colours of the article's artwork (`.plateref/pmr`).
abstract final class TransnistriaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// Passenger flag: red-green-red.
  static const Color flagRed = Color(0xFFDE0000);
  static const Color flagGreen = Color(0xFF068E6B);

  /// The state plates' artwork draws the flag in pure red and green.
  static const Color stateRed = Color(0xFFFF0000);
  static const Color stateGreen = Color(0xFF00FF00);

  static const Color interiorBlue = Color(0xFF00A2E8);
  static const Color diplomaticInk = Color(0xFF0235E6);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
}
