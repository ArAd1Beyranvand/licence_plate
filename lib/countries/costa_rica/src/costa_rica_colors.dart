import 'package:flutter/widgets.dart';

/// The colours a 2013-series Costa Rican plate is printed in: the modal
/// colour of a region of the offline-flattened Wikipedia/Commons references
/// (`.plateref/cr/flat_*.png`), not the article's colour words. Frame and
/// ink are one colour on every plate but the electric one.
abstract final class CostaRicaColors {
  static const Color white = Color(0xFFFFFFFF);

  /// Digits and frame of private, disabled and motorcycle plates.
  static const Color blue = Color(0xFF001A7C);

  /// Digits and frame of commercial, truck, TSJ taxi and official plates;
  /// also the TA taxi's field.
  static const Color red = Color(0xFFD00101);
  static const Color black = Color(0xFF010101);
  static const Color green = Color(0xFF176127);

  /// The security hologram strip down the left edge of every plate.
  static const Color hologram = Color(0xFF939393);

  /// The side strip of bus, taxi, commercial, truck and motorcycle plates.
  static const Color stripYellow = Color(0xFFFEEE00);

  /// International-mission field (photograph of the original artwork).
  static const Color missionYellow = Color(0xFFF1F404);

  /// Historical-vehicle field (photograph of the original artwork).
  static const Color historicYellow = Color(0xFFEFEC02);

  /// Electric-vehicle field, digits and frame (the frame is a darker blue
  /// than the digits).
  static const Color electricTeal = Color(0xFF00C5A2);
  static const Color electricInk = Color(0xFF234286);
  static const Color electricFrame = Color(0xFF00127A);

  /// The blue square behind the disabled-driver pictogram.
  static const Color accessBlue = Color(0xFF0000A4);

  /// Flag, from `Flag_of_Costa_Rica.svg`.
  static const Color flagBlue = Color(0xFF001489);
  static const Color flagRed = Color(0xFFDA291C);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
