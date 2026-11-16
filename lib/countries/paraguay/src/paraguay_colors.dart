import 'package:flutter/widgets.dart';

/// Colours of the Paraguayan plate, modal pixels of the colour-balanced flat
/// photograph (`.plateref/py`): the country band `0F3B9E`, the face `F1EDE9`.
/// The ink is the article's black (the photographed glyphs are carbon-pattern
/// foil, `1B1813` at their darkest). The flag stripes are the plate's `B31E25`
/// red and white over the band's blue.
abstract final class ParaguayColors {
  static const Color white = Color(0xFFF1EDE9);
  static const Color black = Color(0xFF1B1813);
  static const Color band = Color(0xFF0F3B9E);
  static const Color bandText = Color(0xFFFFFFFF);
  static const Color flagRed = Color(0xFFB31E25);
  static const Color flagBlue = Color(0xFF0F3B9E);
}
