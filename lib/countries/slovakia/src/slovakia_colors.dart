import 'package:flutter/widgets.dart';

/// The colours of the Slovak plates, sampled from the flattened photos
/// (modal pixel of the region).
///
/// The euroband `0754BE` is the brief's balanced value for the 2023 plate
/// (raw pixels `0054C8`). The diplomatic field `2457CC` with ink `F8B51D`, and
/// the officials' field `CCC1BD` with ink `4E4E4D`, are photographed colours
/// and carry their photo's lighting. Ordinary plates use the plain black on
/// white of the 3183 sample.
abstract final class SlovakiaColors {
  static const Color white = Color(0xFFEFEFEB);
  static const Color black = Color(0xFF1E1E21);
  static const Color euroBlue = Color(0xFF0754BE);
  static const Color legacyField = Color(0xFFCCD0CF);

  static const Color diplomaticBlue = Color(0xFF2457CC);
  static const Color diplomaticYellow = Color(0xFFF8B51D);

  static const Color officialsField = Color(0xFFCCC1BD);
  static const Color officialsInk = Color(0xFF4E4E4D);

  static const Color electricField = Color(0xFF04C3B7);
  static const Color electricInk = Color(0xFF1E2432);

  static const Color exportField = Color(0xFFE5B948);
  static const Color exportInk = Color(0xFF22232F);

  static const Color dealerInk = Color(0xFFA5322C);

  static const Color importField = Color(0xFFF0F0F0);
  static const Color importInk = Color(0xFF458169);
}
