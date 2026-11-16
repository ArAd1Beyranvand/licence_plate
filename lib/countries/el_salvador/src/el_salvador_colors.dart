import 'package:flutter/widgets.dart';

/// The colours of the 1976 Salvadoran plates, sampled from one flattened photo
/// each (the modal field and ink colour, `platekit`).
///
/// The car and motorcycle values differ because they are two photos of two
/// plates in different light; one photo each cannot say which is the paint.
abstract final class ElSalvadorColors {
  /// Car field. `Matricula_automovilistica_El_Salvador_1976_P-0000`: `CFC6B4`.
  static const Color tan = Color(0xFFCFC6B4);

  /// Car ink, same photo: `46526B`.
  static const Color ink = Color(0xFF46526B);

  /// Motorcycle field. `EL_SALVADOR_1976_motorcycle_plate`: `B2A68D`.
  static const Color motorcycleTan = Color(0xFFB2A68D);

  /// Motorcycle ink, same photo: `33404E`.
  static const Color motorcycleInk = Color(0xFF33404E);
}
