import 'package:flutter/widgets.dart';

/// Sampled from the Wikimedia artwork where it exists (white, black, yellow,
/// red, flag), and from the colour-balanced navy photograph for the navy plate.
abstract final class MoroccoColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// Trailer field, W18 ink and rim, and the red service letters.
  static const Color red = Color(0xFFD8272D);

  /// Diplomatic and international-cooperation field.
  static const Color yellow = Color(0xFFFFC813);

  /// Navy plate field (colour-balanced photograph).
  static const Color navyBlue = Color(0xFF2F62C1);

  /// Navy plate ink: modal colour of the digits in the photograph.
  static const Color navyInk = Color(0xFFDCD0C0);

  /// The official flag's red and green (`Flag_of_Morocco.svg`).
  static const Color flagRed = Color(0xFFC1272D);
  static const Color flagGreen = Color(0xFF006233);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF8A8A8A);
}
