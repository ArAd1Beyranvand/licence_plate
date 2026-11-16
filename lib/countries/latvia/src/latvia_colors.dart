import 'package:flutter/widgets.dart';

/// Colours sampled as the modal pixel of each flattened reference.
abstract final class LatviaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color euBlue = Color(0xFF003399);
  static const Color euInk = Color(0xFFFFFFFF);

  /// Taxi: black on yellow.
  static const Color taxiField = Color(0xFFFFCA0D);

  /// Diplomatic: black on red.
  static const Color diplomaticField = Color(0xFFD60000);

  /// Electric: blue on white; the ink is a light cyan-blue, not the EU blue.
  static const Color electricField = Color(0xFFFBFEFE);
  static const Color electricInk = Color(0xFF0995D0);
}
