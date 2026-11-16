import 'package:flutter/widgets.dart';

/// The colours of the Czech plates, sampled from the flattened photos (modal
/// pixel of the region; the brief's `field`/`ink` columns).
///
/// The current plate takes the vector artwork's pure white and black and the
/// euroband `003399` the brief sampled on it. Every older or special plate is
/// a photograph and keeps its photo's lighting cast.
abstract final class CzechRepublicColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color euroBlue = Color(0xFF003399);

  static const Color plain2001Field = Color(0xFFECEEEB);
  static const Color plain2001Ink = Color(0xFF3B393A);

  static const Color classicField = Color(0xFFDBDEE1);
  static const Color classicInk = Color(0xFF3D4041);

  static const Color classic70sField = Color(0xFFCAD5DE);
  static const Color classic70sInk = Color(0xFF1E232A);

  static const Color commercialField = Color(0xFFDEAE53);
  static const Color commercialInk = Color(0xFF474C55);

  static const Color militaryField = Color(0xFFD3D4D4);
  static const Color militaryInk = Color(0xFF212123);

  static const Color exportField = Color(0xFFE8E8E9);
  static const Color exportInk = Color(0xFF1D1C1B);

  static const Color diplomaticField = Color(0xFFD9DBDA);
  static const Color diplomaticInk = Color(0xFF2D487A);

  static const Color veteranField = Color(0xFFC7CBD3);
  static const Color veteranInk = Color(0xFF1B442E);
}
