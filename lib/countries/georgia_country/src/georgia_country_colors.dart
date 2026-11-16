import 'package:flutter/widgets.dart';

/// Colours sampled from the flattened reference photos (modal colour of a
/// region, `.plateref/ge`). Photographs, so values are `// CALIBRATE`.
abstract final class GeorgiaCountryColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1A1A1A);

  /// Left strip of the current plate and the temporary plate (zone sample).
  static const Color euroBlue = Color(0xFF067DF9); // CALIBRATE

  /// Temporary plate: letters and outline.
  static const Color temporaryRed = Color(0xFFF0564C); // CALIBRATE

  /// EUMM mission plate: white on light blue.
  static const Color missionField = Color(0xFF67B9FB); // CALIBRATE
  static const Color missionInk = Color(0xFFE9F0FD); // CALIBRATE

  /// Military plate: pale on near-black, with a green strip.
  static const Color militaryField = Color(0xFF171416); // CALIBRATE
  static const Color militaryInk = Color(0xFFEDF3F2); // CALIBRATE
  static const Color militaryGreen = Color(0xFF00A868); // CALIBRATE

  /// The year block on the export plate.
  static const Color exportPink = Color(0xFFF2A2D2); // CALIBRATE

  /// The `TRANSIT` bar.
  static const Color transitRed = Color(0xFFC1403C); // CALIBRATE

  /// Embassy plate. **Not sampled**: no photo; the article says white on red.
  static const Color diplomaticRed = Color(0xFFC1272D); // CALIBRATE

  static const Color flagRed = Color(0xFFFF0000);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
