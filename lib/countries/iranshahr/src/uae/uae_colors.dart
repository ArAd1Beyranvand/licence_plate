import 'package:flutter/widgets.dart';

/// Every colour a UAE plate is printed in, sampled from the reference artwork
/// on Wikimedia Commons linked from Wikipedia's "Vehicle registration plates
/// of the United Arab Emirates". The private plates of all seven emirates are
/// pure black on pure white; Abu Dhabi alone adds its red.
abstract final class UaeColors {
  static const Color field = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF000000);

  /// Abu Dhabi's code panel: the left strip of the long plate, the top band of
  /// the short one. The code and captions on it are printed in [field].
  static const Color abuDhabiRed = Color(0xFFD10101);

  /// Abu Dhabi's logo plate: the grey "AbuDhabi" wordmark beside the shield.
  static const Color abuDhabiGrey = Color(0xFF565759);

  /// Dubai's coloured plate: D, U and I in [dubaiBlue], B and A in [dubaiPink].
  static const Color dubaiBlue = Color(0xFF009CD9);
  static const Color dubaiPink = Color(0xFFD95495);

  /// Ajman's logo plate spells AJMAN one colour per letter, in this order.
  static const List<Color> ajmanWord = <Color>[
    Color(0xFFDA1B6B),
    Color(0xFFE16B2B),
    Color(0xFF29307E),
    Color(0xFFB48978),
    Color(0xFF24BED6),
  ];

  /// The national flag, printed on the Ajman and Umm Al Quwain logo plates;
  /// [flagRed] is also the red half of Umm Al Quwain's logo name.
  static const Color flagRed = Color(0xFFFF0000);
  static const Color flagGreen = Color(0xFF00732F);

  /// The red emblems of the new Fujairah and Umm Al Quwain plates.
  static const Color fujairahRed = Color(0xFFF1483E);
  static const Color ummAlQuwainRed = Color(0xFFCC001F);

  /// Input chrome only: the outline core paints under an empty field.
  static const Color inactiveOnLight = Color(0x66666666);
}
