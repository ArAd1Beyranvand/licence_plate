import 'package:flutter/widgets.dart';

/// Colours of Antigua and Barbuda's plates, sampled from the colour-balanced
/// flats in `.plateref/ag`. One photo per design, so no spread is known.
abstract final class AntiguaAndBarbudaColors {
  /// Private field, from the legal-standard graphic: `F8F7F7`.
  static const Color white = Color(0xFFF8F7F7);

  /// Private characters and frame: `000000`.
  static const Color black = Color(0xFF000000);

  /// Government field, a gold, not the article's yellow: `D7BF64`.
  static const Color gold = Color(0xFFD7BF64);

  /// Government characters, a blue-black: `2C243B`.
  static const Color navy = Color(0xFF2C243B);

  /// Taxi field: `244231`.
  static const Color green = Color(0xFF244231);

  /// Taxi characters, an off-white: `E3D4C3`.
  static const Color cream = Color(0xFFE3D4C3);

  /// Taxi sticker ground: `191D1D`.
  static const Color sticker = Color(0xFF191D1D);
}
