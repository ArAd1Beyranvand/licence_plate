import 'package:flutter/widgets.dart';

/// Modal colours of the flattened reference photographs, except the flag's.
abstract final class TrinidadAndTobagoColors {
  /// Private plate (`License_Plate_Trinidad___Tobago`): white on black. Photo.
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFF9FAFB);

  /// Commercial plate: silver letters on a blue-black field. Photo.
  static const Color commercialField = Color(0xFF1D1A20);
  static const Color silver = Color(0xFFB2A89A);

  /// Square plate: black on a weathered white field. Photo.
  static const Color squareField = Color(0xFFE3E3DF);
  static const Color squareInk = Color(0xFF1D191C);

  /// Flag red, from the official flag artwork.
  static const Color flagRed = Color(0xFFDA1A35);
  static const Color flagWhite = Color(0xFFFFFFFF);
  static const Color flagBlack = Color(0xFF000000);

  static const Color inactiveOnDark = Color(0xFF777777);
  static const Color inactiveOnLight = Color(0xFFB0B0B0);
}
