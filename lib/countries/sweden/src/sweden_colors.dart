import 'package:flutter/widgets.dart';

/// Each colour is the modal pixel of a flattened, colour-balanced reference
/// photo. The EU band comes from the photo least affected by lighting.
abstract final class SwedenColors {
  static const Color white = Color(0xFFFAFAF5);
  static const Color black = Color(0xFF131617);

  static const Color euroBlue = Color(0xFF0440A0);
  static const Color euroInk = Color(0xFFFFFFFF);

  static const Color taxiYellow = Color(0xFFFAB604);
  static const Color taxiInk = Color(0xFF160E05);

  static const Color dealerGreen = Color(0xFF02A28A);
  static const Color dealerInk = Color(0xFF040809);

  static const Color diplomaticBlue = Color(0xFF5DC4FC);
  static const Color diplomaticInk = Color(0xFF54565A);

  static const Color temporaryRed = Color(0xFFC60606);
  static const Color temporaryInk = Color(0xFFFAF3F5);

  static const Color militaryBlack = Color(0xFF030201);
  static const Color militaryInk = Color(0xFFFFD400);
}
