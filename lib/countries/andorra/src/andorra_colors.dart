import 'package:flutter/widgets.dart';

/// The colours of the Andorran plates, sampled from the brief's colour-balanced
/// photograph zones (`Andorra-front2014`, `Andorran_licence_plate_6117`), so
/// the fields carry the photographs' lighting: the standard plate is a grey
/// white, not the pure white the article names.
abstract final class AndorraColors {
  static const Color standardField = Color(0xFFD3D4D2);
  static const Color standardInk = Color(0xFF313338);

  /// "AND" and "Principat d'Andorra" on the standard plate.
  static const Color blue = Color(0xFF2F5391);

  static const Color temporaryField = Color(0xFFEFF5F7);
  static const Color temporaryInk = Color(0xFF4C4C4C);

  /// The temporary plate's boxes (modal pixel of the right box).
  static const Color redBox = Color(0xFFED3C30);

  /// "AND" and "Principat d'Andorra" on the temporary plate.
  static const Color redText = Color(0xFFD84B49);

  static const Color white = Color(0xFFFFFFFF);
}
