import 'package:flutter/widgets.dart';

/// The colours a Pakistani plate is printed in, the modal colour of a region
/// of the Wikipedia/Commons artwork (flattened to plate units by platekit).
abstract final class PakistanColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// Sindh field (`Pakistan - License Plate - Sindh.png`).
  static const Color sindhYellow = Color(0xFFFFC913);

  /// Punjab's left strip.
  static const Color punjabGreen = Color(0xFF00AE4E);

  /// Islamabad's left strip: the modal colour of the Faisal Mosque photograph
  /// printed on it, a dusk sky.
  static const Color ictStrip = Color(0xFF554F69);

  /// Flag green, as drawn in `Flag_of_Pakistan.svg`.
  static const Color flagGreen = Color(0xFF01411C);
}
