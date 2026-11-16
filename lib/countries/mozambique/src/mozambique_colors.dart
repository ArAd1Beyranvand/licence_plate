import 'package:flutter/widgets.dart';

/// Modal pixels of the flattened photo regions. The 2011 plate fades from
/// [modernTop] to [modernFoot]; the pre-2011 plates are light ink on a dark
/// field.
abstract final class MozambiqueColors {
  static const Color modernTop = Color(0xFFE7E5E4);
  static const Color modernMiddle = Color(0xFFD8E4E4);
  static const Color modernFoot = Color(0xFFBDE5F5);
  static const Color modernInk = Color(0xFF2B2523);

  static const Color legacyField = Color(0xFF2E313D);
  static const Color legacyInk = Color(0xFFEDEEF0);

  static const Color legacyRowField = Color(0xFF635953);
  static const Color legacyRowInk = Color(0xFFF2F4F3);
}
