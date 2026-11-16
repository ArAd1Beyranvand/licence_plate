import 'package:flutter/widgets.dart';

/// Modal colours of the field and glyph pixels in reference photographs
/// (`.plateref/mg`). The photographs differ in exposure, so the standard black
/// and silver-white come from one photograph and are shared by the temporary
/// and dealer plates.
abstract final class MadagascarColors {
  /// Standard, temporary and dealer field.
  static const Color field = Color(0xFF2B292F);

  /// Their characters.
  static const Color ink = Color(0xFFEEF1F3);

  /// Pre-2014 white plate field and its ink.
  static const Color legacyField = Color(0xFFE1E0E1);
  static const Color legacyInk = Color(0xFF010103);

  /// Military field and its hand-painted ink.
  static const Color militaryField = Color(0xFF443D40);
  static const Color militaryInk = Color(0xFFAFB9AB);

  /// Diplomatic field (a teal, not the article's "green") and ink.
  static const Color diplomaticField = Color(0xFF02827A);
  static const Color diplomaticInk = Color(0xFFD9D2D2);

  /// An empty slot's hint. Not measured.
  static const Color inactive = Color(0xFF6E6E6E);
}
