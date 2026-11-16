import 'package:flutter/widgets.dart';

/// Red from the flag artwork (`Flag_of_the_Isle_of_Man.svg`, `#cf142b`); the
/// photographed strips read as the same red, darkened by the camera. Field and
/// ink are sampled from the platekit-flattened `Licenceplate_of_Isle_of_Man_2`
/// (white) and `NMN-835-H` (yellow).
abstract final class IsleOfManColors {
  static const Color red = Color(0xFFCF142B);
  static const Color white = Color(0xFFE6E7E6);
  static const Color yellow = Color(0xFFFDDB3B);
  static const Color black = Color(0xFF1E1317);
  static const Color classicField = Color(0xFF1A1A1A);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
