import 'package:flutter/widgets.dart';

/// The colours an Australian plate is printed in, sampled from the pixels of
/// the flattened Wikipedia photographs (`.plateref/au`, the modal colour of a
/// region). Every one is from a photograph, not from vector artwork, so each
/// carries its lighting: `// CALIBRATE`.
abstract final class AustraliaColors {
  static const Color nswYellow = Color(0xFFE6DC21); // CALIBRATE
  static const Color waField = Color(0xFFF3F3F2); // CALIBRATE
  static const Color actField = Color(0xFFF2EEE5); // CALIBRATE
  static const Color ntField = Color(0xFFE5E4DF); // CALIBRATE
  static const Color qldField = Color(0xFFEAEEEB); // CALIBRATE
  static const Color saField = Color(0xFFE1E4E6); // CALIBRATE
  static const Color tasField = Color(0xFFE4E2DA); // CALIBRATE
  static const Color vicField = Color(0xFFEFECED); // CALIBRATE
  static const Color heavyField = Color(0xFFE9EAEB); // CALIBRATE
  static const Color firsYellow = Color(0xFFE8C70D); // CALIBRATE
  static const Color armyField = Color(0xFFE1DDD9); // CALIBRATE
  static const Color airForceField = Color(0xFFEDEAE2); // CALIBRATE
  static const Color defenceField = Color(0xFFF5F5F4); // CALIBRATE
  static const Color diplomaticBlue = Color(0xFF408FE3); // CALIBRATE

  static const Color nswBlack = Color(0xFF121912); // CALIBRATE
  static const Color ntRed = Color(
    0xFFF93F24,
  ); // CALIBRATE: red-orange, not the article's "ochre"
  static const Color actBlue = Color(0xFF0F3BDD); // CALIBRATE
  static const Color qldMaroon = Color(0xFF411819); // CALIBRATE
  static const Color saBlack = Color(0xFF161E28); // CALIBRATE
  static const Color tasBlue = Color(0xFF1F4291); // CALIBRATE
  static const Color vicBlue = Color(0xFF274380); // CALIBRATE
  static const Color waBlue = Color(0xFF2147B9); // CALIBRATE
  static const Color heavyBlack = Color(0xFF3A4541); // CALIBRATE
  static const Color firsGreen = Color(0xFF248265); // CALIBRATE
  static const Color armyGreen = Color(0xFF104B45); // CALIBRATE
  static const Color airForceNavy = Color(0xFF0F284C); // CALIBRATE
  static const Color defenceBlue = Color(0xFF2B4EAE); // CALIBRATE
  static const Color diplomaticBlack = Color(0xFF0F1012); // CALIBRATE

  /// The legend and slogan of the RAAF plate (shaded in the photo).
  static const Color airForceRed = Color(0xFF95281B); // CALIBRATE

  /// The National Heavy Vehicle band, a different blue from the SA/VIC inks.
  static const Color heavyBand = Color(0xFF2E40AD); // CALIBRATE

  static const Color white0 = Color(0xFFFFFFFF);

  /// Legend on a coloured band.
  static const Color white = Color(0xFFFFFFFF);

  // Flag of Australia, `Flag_of_Australia_(converted).svg`.
  static const Color flagBlue = Color(0xFF012169);
  static const Color flagRed = Color(0xFFE4002B);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
}
