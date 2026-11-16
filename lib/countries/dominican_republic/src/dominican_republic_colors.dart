import 'package:flutter/widgets.dart';

/// Sampled as the modal colour of a region of each flattened photo
/// (`.plateref/do/flat_*.png`). Where the article's prose disagrees, the
/// photos win: the 1980 plate it calls light green is pale grey-white.
abstract final class DominicanRepublicColors {
  /// 1990 passenger plate: cream field, near-black ink.
  static const Color cream = Color(0xFFCFC091);
  static const Color creamInk = Color(0xFF191222);

  /// 1980 passenger plate: grey-white field, dark ink.
  static const Color greyWhite = Color(0xFFC8CBC3);
  static const Color greyWhiteInk = Color(0xFF22151F);

  /// 1993-94 private plate: oxidised red field, off-white ink.
  static const Color red = Color(0xFFA34B3B);
  static const Color redInk = Color(0xFFF8EBE4);

  /// 1986 passenger plate: turquoise field, brown-black ink.
  static const Color turquoise = Color(0xFF94C4C3);
  static const Color turquoiseInk = Color(0xFF3E1E1F);

  /// 2017 exempt plate: white field, black ink, a dark green head and a
  /// light green foot.
  static const Color white = Color(0xFFCFD2CB);
  static const Color black = Color(0xFF0D1816);
  static const Color darkGreen = Color(0xFF2B5D1F);
  static const Color lightGreen = Color(0xFF6BB349);

  static const Color inactive = Color(0xFF8A8A80);
}
