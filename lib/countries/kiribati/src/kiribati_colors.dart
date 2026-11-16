import 'package:flutter/widgets.dart';

/// The colours of Kiribati's plates, sampled from the flattened photos
/// (`Kiribati_license_plate_graphic`: field `030303`, ink `FFFFFF`; the Betio
/// photo gives `000000` / `FEFEFE`, the same plate within photo noise).
abstract final class KiribatiColors {
  static const Color field = Color(0xFF030303);
  static const Color ink = Color(0xFFFFFFFF);
  static const Color inactive = Color(0xFF6E6E6E);
}
