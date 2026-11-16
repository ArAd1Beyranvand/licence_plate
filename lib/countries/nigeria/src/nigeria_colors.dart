import 'package:flutter/widgets.dart';

/// The colours of the 2011 Nigerian plates, sampled from the flattened
/// references in `.plateref/ng` (modal colour of a region).
abstract final class NigeriaColors {
  /// Field of the clean Lagos artwork (`____2012`).
  static const Color white = Color(0xFFFEFEFE);

  /// Private ink, same artwork. Photographs read 1A3B8D..2E5999 in shade.
  static const Color blue = Color(0xFF2343FD);

  /// Commercial ink: the Lagos commercial artwork.
  static const Color red = Color(0xFFFE0000);

  /// The flag sticker on the plate (`007E45` in the commercial artwork).
  static const Color stickerGreen = Color(0xFF007E45);

  /// The national flag's green, from `Flag_of_Nigeria.svg`.
  static const Color flagGreen = Color(0xFF008751);

  /// Caption ink. Not sampled: the artwork prints the state name in an
  /// outlined face and the photographs in near-black.
  static const Color caption = Color(0xFF555555); // CALIBRATE

  /// The frame. Not sampled: no reference shows a rim line.
  static const Color rim = Color(0xFFB0B0B0); // CALIBRATE

  static const Color inactive = Color(0xFFB0B0B0);
}
