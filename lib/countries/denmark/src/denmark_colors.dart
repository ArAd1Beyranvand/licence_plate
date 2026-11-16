import 'package:flutter/widgets.dart';

/// Colours sampled as the modal pixel of each flattened reference. Values
/// that exist only in a photograph are marked `// CALIBRATE`.
abstract final class DenmarkColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// The frame of private and export plates, and the ink of the fixed
  /// temporary plate.
  static const Color red = Color(0xFFFF0000);

  /// Greenland: field and ink are photograph values; the frame was only seen
  /// to be red.
  static const Color greenlandField = Color(0xFFF1F7FA); // CALIBRATE
  static const Color greenlandInk = Color(0xFF181D2A); // CALIBRATE

  /// Parrot plates: the yellow letters block, from the vector artwork.
  static const Color parrotYellow = Color(0xFFE5FF26);

  /// Commercial plates: the whole field, from the 1976 artwork.
  static const Color vanYellow = Color(0xFFECE400);

  static const Color diplomaticBlue = Color(0xFF345BCA);

  /// The EU stripe and the grey security hologram beside it.
  static const Color euBlue = Color(0xFF05689F);
  static const Color hologram = Color(0xFFE6E6E6);

  /// The temporary export plate's year patch.
  static const Color exportRed = Color(0xFFD90614);

  /// Faroe Islands, photograph only.
  static const Color faroeField = Color(0xFFD8D7CD); // CALIBRATE
  static const Color faroeInk = Color(0xFF345484); // CALIBRATE
  static const Color faroePanel = Color(0xFF1171C1); // CALIBRATE
  static const Color faroeFlagRed = Color(0xFFEF303E); // CALIBRATE
  static const Color faroeFlagBlue = Color(0xFF0072C6); // CALIBRATE

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
