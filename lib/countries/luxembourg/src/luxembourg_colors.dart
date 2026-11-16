import 'package:flutter/widgets.dart';

/// Modal colours of regions of the colour-balanced flat references
/// (`.plateref/lu`, 520×110 mm). The diplomatic field is the CD photograph's;
/// the military field and ink are from its photograph.
abstract final class LuxembourgColors {
  static const Color yellow = Color(0xFFFBBD0B);
  static const Color black = Color(0xFF0B0D09);
  static const Color euroBlue = Color(0xFF0141B4);
  static const Color white = Color(0xFFFFFFFF);
  static const Color militaryField = Color(0xFF1F232B);
  static const Color militaryInk = Color(0xFFEFF4FA);
  static const Color inactive = Color(0x66666666);
}
