import 'package:flutter/widgets.dart';

/// Field and ink of each series, the modal colour of the plate region in the
/// flattened references. All are photographs except [yellow], which is clean
/// artwork; photographed values are `// CALIBRATE`.
abstract final class BahamasColors {
  /// 1987–89 field and the digits' black. Artwork.
  static const Color yellow = Color(0xFFFFDE00);
  static const Color black = Color(0xFF000000);

  /// 1990–91 field and its cast-aluminium white. Photo.
  static const Color green = Color(0xFF16957F); // CALIBRATE
  static const Color greenInk = Color(0xFFF1E2E2); // CALIBRATE

  /// 1977 field, which the article calls "cyan", and its near-black print.
  static const Color pale = Color(0xFFABC2B7); // CALIBRATE
  static const Color paleInk = Color(0xFF2C171D); // CALIBRATE

  /// 1992–96 truck plate: blue print on a dull yellow. Photo, creased.
  static const Color landfallField = Color(0xFFDAC153); // CALIBRATE
  static const Color landfallInk = Color(0xFF2571E3); // CALIBRATE

  /// 1997–2015: gold on blue. Photo, blurred and in perspective; the gold
  /// is darkened by the blur.
  static const Color blue = Color(0xFF1057E6); // CALIBRATE
  static const Color gold = Color(0xFFA87B06); // CALIBRATE

  /// Flag aquamarine and gold, from `Flag_of_the_Bahamas.svg`.
  static const Color flagAqua = Color(0xFF00778B);
  static const Color flagGold = Color(0xFFFFC72C);

  static const Color inactiveOnDark = Color(0xFF5A5A5A);
  static const Color inactiveOnLight = Color(0xFFB0B0B0);
}
