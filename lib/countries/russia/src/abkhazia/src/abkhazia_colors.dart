import 'package:flutter/widgets.dart';

/// Modal colours of the reference artwork; photographed values, whose lighting
/// shifts them, are marked `CALIBRATE`.
abstract final class AbkhaziaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// The diplomatic plate's field and its silver ink.
  static const Color diplomaticRed = Color(0xFF7D2728); // CALIBRATE
  static const Color diplomaticInk = Color(0xFFC8C8C8); // CALIBRATE

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0x80C8C8C8);
}
