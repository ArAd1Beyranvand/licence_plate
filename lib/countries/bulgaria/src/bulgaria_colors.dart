import 'package:flutter/widgets.dart';

/// The colours of the Bulgarian plates, the modal pixel of each region of the
/// flattened photos (`platekit` white-balanced values).
///
/// [euroBlue] reads `003399` on both the EU and the flag bands. The electric
/// green, repeater red, foreigner blue and diplomatic red are photographed
/// colours and carry their photo's lighting. The flag's green and red are the
/// official ones.
abstract final class BulgariaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color euroBlue = Color(0xFF003399);

  static const Color electricGreen = Color(0xFF4C7151);
  static const Color repeaterRed = Color(0xFFCE605F);
  static const Color foreignBlue = Color(0xFF29B6FF);
  static const Color diplomaticRed = Color(0xFFF2664E);

  static const Color flagGreen = Color(0xFF00966E);
  static const Color flagRed = Color(0xFFD62612);
}
