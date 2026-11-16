import 'package:flutter/widgets.dart';

/// The car and two-wheeler plates are the modal pixels of the vector artwork,
/// so the "black" kei commercial plate is the artwork's mid grey. The
/// diplomatic and export values are colour-balanced photograph samples; the
/// flag's colours keep the export photograph's shade.
abstract final class JapanColors {
  static const Color white = Color(0xFFF6F6F6);
  static const Color green = Color(0xFF4C8663);
  static const Color yellow = Color(0xFFFFDE4C);
  static const Color black = Color(0xFF747474);

  static const Color bikeGreen = Color(0xFF458D61);
  static const Color bikeWhite = Color(0xFFFBFCFC);

  static const Color diplomaticField = Color(0xFF063F96);
  static const Color diplomaticInk = Color(0xFFD7E8EE);

  static const Color exportField = Color(0xFFBDC4D3);
  static const Color exportInk = Color(0xFF142925);

  /// The inspection sticker on the two-wheeler plates: pale blue, with a dark
  /// grey ellipse behind the year's first two digits.
  static const Color sticker = Color(0xFFA7CDEB);
  static const Color stickerInk = Color(0xFF4C4C4C);

  static const Color flagWhite = Color(0xFFA4AFC3);
  static const Color flagRed = Color(0xFF9B3041);
}
