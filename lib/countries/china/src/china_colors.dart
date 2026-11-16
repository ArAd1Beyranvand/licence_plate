import 'package:flutter/widgets.dart';

/// The colours a Chinese plate is printed in, sampled as the modal colour of
/// a region of the Wikipedia/Commons references (`platekit` colour-balanced
/// photos). Photographs are lit differently, so each is marked `// CALIBRATE`
/// where no clean artwork exists.
abstract final class ChinaColors {
  /// Small-vehicle field. The Hunan and Fujian photos, 2687EB and 1E7CEC.
  static const Color blue = Color(0xFF2687EB); // CALIBRATE
  static const Color white = Color(0xFFF5FAFD);

  /// Large-vehicle and driving-school field. `GA36-2007_C.1.1`.
  static const Color yellow = Color(0xFFFDC003);
  static const Color yellowInk = Color(0xFF070200);

  /// Cross-border (港/澳) field and ink. `GD-HK_Plate`.
  static const Color black = Color(0xFF2B2A2D); // CALIBRATE
  static const Color blackInk = Color(0xFFEFEFF1);

  /// New Energy fields, from the Guangdong photo of both plates. The small
  /// plate is a white-to-green gradient in print; this is its modal colour,
  /// as `PlateSection` has no gradient.
  static const Color newEnergySmall = Color(0xFF7BC47C); // CALIBRATE
  static const Color newEnergyLarge = Color(0xFF61C255); // CALIBRATE

  /// The yellow province end of a large New Energy plate.
  static const Color newEnergyYellow = Color(0xFFE4CF29); // CALIBRATE
  static const Color newEnergyInk = Color(0xFF0E0D0D);

  /// Diplomatic: black field, white digits, red 使. The pre-2017 photo.
  static const Color diplomaticInk = Color(0xFFFBFCF1);
  static const Color diplomaticMark = Color(0xFFF54F35);

  /// Flag, `Flag_of_the_People's_Republic_of_China.svg`.
  static const Color flagRed = Color(0xFFDE2910);
  static const Color flagYellow = Color(0xFFFFDE00);

  static const Color inactiveOnDark = Color(0xFF5A5A5A);
  static const Color inactiveOnLight = Color(0xFFB0B0B0);
}
