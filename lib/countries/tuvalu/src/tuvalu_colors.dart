import 'package:flutter/widgets.dart';

/// The colours of Tuvalu's plate, sampled from `Tuvalu_license_plate_graphic`
/// (field `040404` after the offline balance, ink `FFFFFF`). The inactive grey
/// is not sampled.
abstract final class TuvaluColors {
  static const Color field = Color(0xFF040404);
  static const Color ink = Color(0xFFFFFFFF);
  static const Color inactive = Color(0xFF6E6E6E);
}
