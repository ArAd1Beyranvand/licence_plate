import 'package:flutter/widgets.dart';

/// The colours of Fijian plates.
///
/// [white]/[ink] and [aged]/[agedInk] are sampled: the modal colour of the
/// field and of the stroke interiors of one flattened photo each
/// (`Fiji_plate_2012`, `E-0845`), white-balanced in the same photo. [aged] is
/// yellowed by decades of sun, not a different paint. [government] and
/// [governmentInk] are NOT sampled: no photo shows a government plate and the
/// article only says "white on blue".
abstract final class FijiColors {
  /// `Fiji_plate_2012`: `E8E7E4`.
  static const Color white = Color(0xFFE8E7E4);

  /// Its ink, same photo: `322F2E`.
  static const Color ink = Color(0xFF322F2E);

  /// `E-0845`: `E7E7B5`.
  static const Color aged = Color(0xFFE7E7B5);

  /// Its ink, same photo: `3D3C30`.
  static const Color agedInk = Color(0xFF3D3C30);

  /// `Fiji_Motorcycle_registration_plates`: `E4DEDD`, ink `2D1D26`. CHECK-fitted.
  static const Color motorcycle = Color(0xFFE4DEDD);
  static const Color motorcycleInk = Color(0xFF2D1D26);

  /// Unsampled: the article's "white on blue".
  static const Color government = Color(0xFF1F4E9C); // CALIBRATE
  static const Color governmentInk = Color(0xFFFFFFFF);
}
