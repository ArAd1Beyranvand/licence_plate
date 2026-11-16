import 'package:flutter/widgets.dart';

/// Sampled from the platekit-flattened photographs (`GBG_white_front_plate`,
/// `Guernsey_license_plate_rear_yellow`, `License_plate_of_Alderney`).
abstract final class GuernseyColors {
  static const Color white = Color(0xFFE9EAEB);
  static const Color black = Color(0xFF020306);

  static const Color rearYellow = Color(0xFFD4BC22);
  static const Color rearInk = Color(0xFF251F0D);

  /// Alderney's rear plate is a deeper, orange-leaning yellow than Guernsey's.
  static const Color alderneyYellow = Color(0xFFE0AF33);
  static const Color alderneyInk = Color(0xFF3C3A38);
}
