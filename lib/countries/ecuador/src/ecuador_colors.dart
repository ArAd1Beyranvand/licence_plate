import 'package:flutter/widgets.dart';

/// The colours an Ecuadorian plate is printed in, sampled from the pixels of
/// the 2012 Commons artwork (the modal colour of a region of the flattened,
/// colour-balanced references), never read off the article's adjectives.
abstract final class EcuadorColors {
  /// Plate face on every category: the article's "white-silver".
  static const Color face = Color(0xFFE6E6E6);

  /// Characters and caption on every category.
  static const Color ink = Color(0xFF000000);

  /// The thin frame at the plate's edge.
  static const Color rim = Color(0xFF585858);

  /// Commercial band.
  static const Color orange = Color(0xFFDC5F00);

  /// Government and official-use band.
  static const Color gold = Color(0xFFFEE300);

  /// Decentralised-government band: a lime green.
  static const Color lime = Color(0xFF32CD32);

  /// Diplomatic band.
  static const Color blue = Color(0xFF0000FA);

  /// International-organisation band.
  static const Color red = Color(0xFFFA0000);

  /// Flag stripes, from `Flag_of_Ecuador.svg`.
  static const Color flagYellow = Color(0xFFFFDD00);
  static const Color flagBlue = Color(0xFF034EA2);
  static const Color flagRed = Color(0xFFED1C24);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
}
