import 'package:flutter/widgets.dart';

/// Modal colours of the reference artwork; photographed values, whose lighting
/// shifts them, are marked `CALIBRATE`.
abstract final class RussiaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// A warm black, unlike the private plate's ink.
  static const Color militaryField = Color(0xFF1F1A17); // CALIBRATE
  static const Color policeBlue = Color(0xFF064DB9); // CALIBRATE
  static const Color diplomaticRed = Color(0xFFFF0000); // CALIBRATE
  static const Color taxiYellow = Color(0xFFFFD800); // CALIBRATE

  static const Color transitYellow = Color(0xFFFEFE00); // CALIBRATE

  /// The transit plate's hologram sticker.
  static const Color hologram = Color(0xFFA9A6A6); // CALIBRATE

  static const Color flagBlue = Color(0xFF0039A6);
  static const Color flagRed = Color(0xFFD52B1E);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0x80FFFFFF);
}
