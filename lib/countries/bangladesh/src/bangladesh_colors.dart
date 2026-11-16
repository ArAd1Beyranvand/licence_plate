import 'package:flutter/widgets.dart';

/// The article gives no hex values and the one photograph is under-lit
/// (its field samples C3C3BE), so these are the plates' named colours at
/// full strength, not pixel samples.
abstract final class BangladeshColors {
  /// Private-vehicle field.
  static const Color white = Color(0xFFFFFFFF);

  /// Ink of the private and commercial plates.
  static const Color black = Color(0xFF111111);

  /// Field of the commercial and electric plates.
  static const Color green = Color(0xFF1E8C3E);
}
