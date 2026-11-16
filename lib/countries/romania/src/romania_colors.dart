import 'package:flutter/widgets.dart';

/// Plate colours read off photographs, colour-balanced against each plate's
/// own white, so those marked `CALIBRATE` are good to a few steps only.
abstract final class RomaniaColors {
  static const Color white = Color(0xFFFFFFFF);

  /// Standard, military and Ministry of Interior ink.
  static const Color black = Color(0xFF14181E); // CALIBRATE

  static const Color euroBlue = Color(0xFF003399);

  static const Color euroGold = Color(0xFFFFCC00);

  /// Short-term temporary ink.
  static const Color temporaryRed = Color(0xFFA51C1E); // CALIBRATE

  /// Test-vehicle ink and rim; brighter than [temporaryRed].
  static const Color testRed = Color(0xFFE1273B); // CALIBRATE

  static const Color electricGreen = Color(0xFF0F654B); // CALIBRATE

  /// Diplomatic and consular ink. The diplomatic photograph is washed out by
  /// glare, so both take the deeper consular value.
  static const Color diplomaticBlue = Color(0xFF002496); // CALIBRATE

  static const Color localYellow = Color(0xFFF9D841); // CALIBRATE

  static const Color localInk = Color(0xFF181B20); // CALIBRATE

  static const Color flagBlue = Color(0xFF002B7F);
  static const Color flagYellow = Color(0xFFFCD116);
  static const Color flagRed = Color(0xFFCE1126);
}
