import 'package:flutter/widgets.dart';

/// Colours sampled as the modal pixel of each flattened reference.
///
/// Regular, motorcycle and export plates share one black-on-white pair. The
/// diplomatic and Åland values are balanced from their own photographs, the
/// only references for them.
abstract final class FinlandColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color euBlue = Color(0xFF003399);
  static const Color euInk = Color(0xFFFFFFFF);

  static const Color diplomaticBlue = Color(0xFF4BB6FF);
  static const Color diplomaticInk = Color(0xFFF2F1F3);

  static const Color alandField = Color(0xFFDADAD8);
  static const Color alandBlue = Color(0xFF2969BA);

  static const Color exportRed = Color(0xFFF03E3E);
  static const Color exportStampInk = Color(0xFFFFFFFF);

  /// Åland flag: blue field, red cross with a yellow border.
  static const Color alandFlagBlue = Color(0xFF0064AD);
  static const Color alandFlagYellow = Color(0xFFFFD300);
  static const Color alandFlagRed = Color(0xFFDA0E15);
}
