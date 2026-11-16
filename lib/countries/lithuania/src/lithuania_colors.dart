import 'package:flutter/widgets.dart';

/// Field and ink colours are the modal pixels of the colour-balanced
/// references; the EU panel is the flag's blue, as the photographs vary too
/// much with light to sample.
abstract final class LithuaniaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF11100D);
  static const Color euBlue = Color(0xFF003399);
  static const Color euInk = Color(0xFFFFFFFF);

  /// Taxi plate issued before April 2018 (the current one is black on white).
  static const Color taxiField = Color(0xFFF1C100);
  static const Color taxiInk = Color(0xFF000803);

  /// Dealer and temporary plates: red characters and frame on white.
  static const Color red = Color(0xFFC91F2B);

  /// Military plate: light characters on dark grey.
  static const Color militaryField = Color(0xFF615D5D);
  static const Color militaryInk = Color(0xFFEEEEEF);

  /// Agricultural plate: green characters on white.
  static const Color agriculturalInk = Color(0xFF366656);

  /// Diplomatic plate: pale characters on green.
  static const Color diplomaticField = Color(0xFF03BEA2);
  static const Color diplomaticInk = Color(0xFFBEE8E8);

  /// The national flag (Flag_of_Lithuania.svg), for the military plate.
  static const Color flagYellow = Color(0xFFFDB913);
  static const Color flagGreen = Color(0xFF006A44);
  static const Color flagRed = Color(0xFFC1272D);
}
