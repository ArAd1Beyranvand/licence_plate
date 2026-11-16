import 'package:flutter/widgets.dart';

/// The colours a Singaporean plate is printed in, sampled from the pixels of
/// the Wikipedia/Commons references (the modal colour of a region).
///
/// The illustrations (off-peak, hazardous cargo, restricted use, 2000 front)
/// are clean artwork and are the source where they exist. Values from
/// photographs are marked `// CALIBRATE`: the field is shaded and the
/// embossed ink reads grey.
abstract final class SingaporeColors {
  /// Standard field. `Singaporean_License_Plate_SNB9538E`.
  static const Color black = Color(0xFF1B1E20); // CALIBRATE

  /// Standard ink. `Singaporean_License_Plate_SLR5791E`.
  static const Color white = Color(0xFFE1E4E2); // CALIBRATE

  /// Euro-style front field and its ink. 2000 front/rear illustration.
  static const Color frontField = Color(0xFFFFFFFF);
  static const Color frontInk = Color(0xFF231F20);

  /// Euro-style rear field. 1990 Hyundai photo; the ink is its black.
  static const Color yellow = Color(0xFFF0DF6B); // CALIBRATE
  static const Color yellowInk = Color(0xFF444643); // CALIBRATE

  /// Off-peak field, white ink. Illustration.
  static const Color offPeak = Color(0xFFC0504E);

  /// Hazardous cargo field and its black ink. Illustration.
  static const Color hazardousOrange = Color(0xFFFF6F01);
  static const Color hazardousInk = Color(0xFF010001);

  /// Pulau Ubin field and gold ink. Photograph.
  static const Color pulauUbin = Color(0xFF0CA282); // CALIBRATE
  static const Color pulauUbinInk = Color(0xFFE3D084); // CALIBRATE

  /// Classic vehicle: red upper half, ink. Photograph.
  static const Color classicRed = Color(0xFF791A14); // CALIBRATE
  static const Color classicGold = Color(0xFFB39755); // CALIBRATE

  /// Classic vehicle's lower half, read off the photo's left edge (the
  /// brief's modal colour is the red).
  static const Color classicYellow = Color(0xFFB86F0A); // CALIBRATE

  /// Restricted use: red upper half and emerald green lower half, white ink.
  /// Illustration.
  static const Color restrictedRed = Color(0xFFC0504E);
  static const Color restrictedGreen = Color(0xFF9DBB5C);

  /// Flag, from `Flag_of_Singapore.svg`.
  static const Color flagRed = Color(0xFFED2939);
  static const Color flagWhite = Color(0xFFFFFFFF);

  static const Color inactiveOnDark = Color(0xFF5A5A5A);
  static const Color inactiveOnLight = Color(0xFFB0B0B0);
}
