import 'package:flutter/widgets.dart';

/// Field and ink colours are the modal pixels of the colour-balanced
/// references. The EU panel blue is the one sampled from the clean artwork
/// (`0043A2`), not the flag's `003399`; the red of the national flag is the
/// flag's own, being too small on the plates to sample.
abstract final class PolandColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color panelBlue = Color(0xFF0043A2);
  static const Color panelInk = Color(0xFFFFFFFF);

  /// Electric and hydrogen vehicles: black on light green.
  static const Color electricField = Color(0xFFA1EA9D);

  /// Temporary and testing plates: red characters and frame on white.
  static const Color red = Color(0xFFC52323);

  /// Professional (dealer) plates: green characters and frame on white.
  static const Color green = Color(0xFF267335);

  /// Classic cars: dark brown on yellow-orange (Zabrze reference; the Brodnica
  /// photograph reads a deeper orange under other light).
  static const Color classicField = Color(0xFFFFB82E);
  static const Color classicInk = Color(0xFF553A2A);

  /// Diplomatic plates: white on dark blue.
  static const Color diplomaticField = Color(0xFF0047AB);
  static const Color diplomaticInk = Color(0xFFFFFFFF);

  /// The national flag: white over red.
  static const Color flagRed = Color(0xFFDC143C);
}
