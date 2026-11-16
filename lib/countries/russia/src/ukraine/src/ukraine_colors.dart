import 'package:flutter/widgets.dart';

/// Colours sampled from the flattened reference plates (modal colour of a
/// region), except where marked as artwork.
abstract final class UkraineColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// The 2015 band behind `UA`.
  static const Color bandBlue = Color(0xFF003399);

  /// The flag's two halves as the 2015 band prints them.
  static const Color flagBlue = Color(0xFF45B0E0);
  static const Color flagYellow = Color(0xFFF8D80F);

  /// The 2004 band is the flag itself.
  static const Color legacyBlue = Color(0xFF33CCFF);
  static const Color legacyYellow = Color(0xFFFFCC00);

  /// 2015 public-transport field.
  static const Color transportYellow = Color(0xFFFFEC11);

  /// Temporary and 1997 diplomatic field.
  static const Color red = Color(0xFFFF0000);

  /// Police field.
  static const Color policeBlue = Color(0xFF0079C1);

  /// Military and volunteer fields.
  static const Color militaryBlack = Color(0xFF000000);
  static const Color volunteerGreen = Color(0xFF1F2A1A);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0x80FFFFFF);
}
