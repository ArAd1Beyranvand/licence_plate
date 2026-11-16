import 'package:flutter/widgets.dart';

/// The colours of Mexican plates, sampled from the colour-balanced flattened
/// photographs (`.plateref/mx`): the modal colour of the field and the mean of
/// the darkest tenth of the serial row for the ink.
///
/// Every plate here is a photograph, so each value carries its lighting and
/// is marked `// CALIBRATE`. Where the article's prose and the pixels
/// disagree the pixels are used: Sonora's field is a saturated orange, the
/// 1992 series is green on white.
abstract final class MexicoColors {
  /// The common state plate: near-black embossed digits on a cool white.
  /// Median of Baja California, Michoacán, Estado de México, Yucatán,
  /// Guerrero, Baja California Sur and Tabasco.
  static const Color white = Color(0xFFE9EDF1); // CALIBRATE
  static const Color black = Color(0xFF14161A); // CALIBRATE

  /// Campeche: the field photographs a blue-grey (`96A2B3`, shaded).
  static const Color campecheField = Color(0xFF96A2B3); // CALIBRATE

  /// Oaxaca: field `D4DCE5`, ink `323037`.
  static const Color oaxacaField = Color(0xFFD4DCE5); // CALIBRATE
  static const Color oaxacaInk = Color(0xFF323037); // CALIBRATE

  /// Sonora: dark brown on orange, the whole plate printed in the orange.
  static const Color sonoraField = Color(0xFFDA9145); // CALIBRATE
  static const Color sonoraInk = Color(0xFF221609); // CALIBRATE

  /// San Luis Potosí: blue digits on white. Unmeasured by the script; read
  /// off the original (125×60 px).
  static const Color slpInk = Color(0xFF021672); // CALIBRATE
  static const Color slpField = Color(0xFFF4F4F6); // CALIBRATE

  /// Veracruz: teal digits (`204948` darkest tenth) on a grey-white.
  static const Color veracruzInk = Color(0xFF2B6B66); // CALIBRATE
  static const Color veracruzField = Color(0xFFDEDFE0); // CALIBRATE

  /// Morelos antique: dark on a grey, field `DDDCD9`.
  static const Color antiqueField = Color(0xFFDDDCD9); // CALIBRATE
  static const Color antiqueInk = Color(0xFF1B1317); // CALIBRATE

  /// Federal tourism (SPF): `151717` on a blue-grey `818F97`.
  static const Color spfField = Color(0xFF818F97); // CALIBRATE
  static const Color spfInk = Color(0xFF151717); // CALIBRATE

  /// The 1992 national series: green on white, framed in the green.
  static const Color legacyField = Color(0xFFFFFDFA);
  static const Color legacyInk = Color(0xFF085A00);

  /// Yucatán's top band (`49834D`).
  static const Color yucatanBand = Color(0xFF49834D); // CALIBRATE

  /// Mexico's flag green, red and white for the country panel colours.
  static const Color flagGreen = Color(0xFF006847);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
