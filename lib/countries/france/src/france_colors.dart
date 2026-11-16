import 'package:flutter/widgets.dart';

/// Sampled from the vector artwork (`License_plate_of_France_AA-229-DB`) for
/// the white plate and its blue; the transit, temporary and diplomatic plates
/// are photographs, so their fields carry some of the photo's lighting.
/// The temporary pink is the offline stage's colour-balanced value.
abstract final class FranceColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color euroBlue = Color(0xFF003399);
  static const Color transitRed = Color(0xFFD23934);
  static const Color temporaryPink = Color(0xFFFF5DC2);
  static const Color temporaryInk = Color(0xFF0D111C);
  static const Color diplomaticGreen = Color(0xFF27B7B8);
  static const Color diplomaticOrange = Color(0xFFFFAC4C);
}
