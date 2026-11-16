import 'package:flutter/widgets.dart';

/// Colours sampled as the modal colour of a region of the flattened
/// references. Values from photographs, whose lighting shifts them, are marked
/// `// CALIBRATE`.
abstract final class GreeceColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color euroBlue = Color(0xFF003CA0);

  static const Color trailerGrey = Color(0xFFD0D0D8); // CALIBRATE

  static const Color governmentOrange = Color(0xFFDD5514); // CALIBRATE
  static const Color governmentInk = Color(0xFF30221E); // CALIBRATE

  static const Color policeField = Color(0xFFB9BABD); // CALIBRATE
  static const Color policeBlue = Color(0xFF233469); // CALIBRATE

  static const Color afgField = Color(0xFFFCF4F0); // CALIBRATE
  static const Color afgInk = Color(0xFF2A2026); // CALIBRATE

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
