import 'package:flutter/widgets.dart';

/// The colours of the 2017 South Sudanese plates.
///
/// [ink] and [taxiInk] are sampled: the median of the darkest pixels of the
/// 2017 private and taxi photographs on worldlicenseplates.com (`191F33` and
/// `26535E`). [white] is NOT sampled: the photographs' field reads `DAE4FC`
/// and `E2E8FF`, a blue cast of the lighting, and the article says white.
/// The flag colours are read off the Commons SVG.
abstract final class SouthSudanColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF191F33);
  static const Color taxiInk = Color(0xFF26535E);

  static const Color flagBlack = Color(0xFF000000);
  static const Color flagRed = Color(0xFFE22028);
  static const Color flagGreen = Color(0xFF00914C);
  static const Color flagBlue = Color(0xFF00B6F2);
  static const Color flagYellow = Color(0xFFFFE51A);
}
