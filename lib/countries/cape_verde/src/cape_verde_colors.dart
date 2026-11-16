import 'package:flutter/widgets.dart';

/// Sampled from the flattened reference photos except where noted. The photos
/// are glare-washed (the black field reads 585A68–707070), so the black,
/// diplomatic white and crimson are estimates.
abstract final class CapeVerdeColors {
  /// Regular and military field.
  static const Color black = Color(0xFF1B1B1E);

  /// Ink and frame on the black plates: `FCFCFC`.
  static const Color white = Color(0xFFFCFCFC);

  /// Free-font plate field: `9A7A08` (photo, `CV-ST-16-KD-G`).
  static const Color ochre = Color(0xFF9A7A08);

  /// Free-font plate ink and frame: `2A0C00`.
  static const Color brown = Color(0xFF2A0C00);

  /// The military plate's flag block: `0382FB`.
  static const Color flagBlue = Color(0xFF0382FB);

  /// Diplomatic field; the photo samples `DAECF8` under glare.
  static const Color diplomaticWhite = Color(0xFFF6F6F8);

  /// Diplomatic ink and frame; the photo samples a washed `9C5372`.
  static const Color crimson = Color(0xFFB43A55);
}
