import 'package:flutter/widgets.dart';

/// Modal pixels of the flattened, colour-balanced photographs, each carrying
/// its photo's lighting (hence `// CALIBRATE`).
abstract final class IcelandColors {
  static const Color white = Color(0xFFF3F1F0); // CALIBRATE

  static const Color blue = Color(0xFF1C48B3); // CALIBRATE

  static const Color red = Color(0xFFBE281D); // CALIBRATE

  static const Color diplomaticGreen = Color(0xFF11C7B7); // CALIBRATE
  static const Color diplomaticInk = Color(0xFFFAF8FA); // CALIBRATE

  static const Color oilYellow = Color(0xFFFEF519); // CALIBRATE
  static const Color oilInk = Color(0xFF5E4613); // CALIBRATE

  static const Color dealerRed = Color(0xFFDD3A46); // CALIBRATE
  static const Color dealerInk = Color(0xFF4E292D); // CALIBRATE

  static const Color offRoadRed = Color(0xFFF32B49); // CALIBRATE
  static const Color offRoadInk = Color(0xFFFCF8F9); // CALIBRATE

  static const Color mopedBlue = Color(0xFF45ADE5); // CALIBRATE
  static const Color mopedInk = Color(0xFFF8F3F1); // CALIBRATE

  static const Color flagBlue = Color(0xFF02529C);
  static const Color flagRed = Color(0xFFDC1E35);

  static const Color black = Color(0xFF151515);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
