import 'package:flutter/widgets.dart';

/// The colours of the Montenegrin plates.
///
/// [band] `09247C`, [white] and [black] `111212` are the modal pixels of the
/// 2008-format vector-like example. The diplomatic yellow `F7AC0C` is the ink
/// of the Norway photo; the agricultural green `349687` and its ink `E4F0EF`
/// are the photographed field and carry its lighting. The disc behind the
/// crest `D87D65` is a photographed red-orange; the article's prose names no
/// colours for it.
abstract final class MontenegroColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF111212);
  static const Color band = Color(0xFF09247C);
  static const Color diplomaticYellow = Color(0xFFF7AC0C);
  static const Color agriculturalField = Color(0xFF349687);
  static const Color agriculturalInk = Color(0xFFE4F0EF);
  static const Color crestDisc = Color(0xFFD87D65);
}
