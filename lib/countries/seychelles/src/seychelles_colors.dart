import 'package:flutter/widgets.dart';

/// Colours of Seychelles's plates, sampled from the article's drawing
/// `Seychelles_old_and_new_license_plates.png` (`.plateref/sc`), which is flat
/// artwork rather than a photograph.
abstract final class SeychellesColors {
  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);

  /// The high-visibility tag.
  static const Color yellow = Color(0xFFFFF200);

  static const Color inactive = Color(0xFF808080);
}
