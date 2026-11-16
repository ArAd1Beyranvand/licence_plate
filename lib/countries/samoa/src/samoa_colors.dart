import 'package:flutter/widgets.dart';

/// Colours of the four Samoan plates, each sampled from its flattened photo
/// (white-balanced by the offline stage). The photos are of different plates
/// in different light, so every pair is one photo's evidence only.
abstract final class SamoaColors {
  /// 2000 plate field. `Samoa_license_plate_5511_2000-2010`: `E1DEDD`.
  static const Color whiteField = Color(0xFFE1DEDD);

  /// Its numerals and frame: `2C6EB4`.
  static const Color blue = Color(0xFF2C6EB4);

  /// Its "SAMOA" and slogan: `AA5B43`, modal red of the slogan strokes.
  static const Color red = Color(0xFFAA5B43);

  /// Late-1950s plate field. `1950_Samoa_license_plate`: `489359`.
  static const Color green = Color(0xFF489359);

  /// Its numerals: `F3FBF5`.
  static const Color greenInk = Color(0xFFF3FBF5);

  /// 1979 plate field. `Samoa_license_plate_graphic`: `99F7BA`. A drawn
  /// graphic, not a photo, so this is the artwork's colour.
  static const Color mint = Color(0xFF99F7BA);

  /// Its numerals.
  static const Color black = Color(0xFF000000);

  /// Government plate field. `WESTERN_SAMOA_1979-2000_government...`: `7CCAC3`.
  static const Color teal = Color(0xFF7CCAC3);

  /// Its embossed characters: `361917`.
  static const Color maroon = Color(0xFF361917);
}
