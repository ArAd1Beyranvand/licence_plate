import 'package:flutter/widgets.dart';

/// Sampled from the flattened references (`.plateref/ar/flat_*.png`): the
/// modal colour of each region. The two flag colours are the national flag's.
abstract final class ArgentinaColors {
  /// Mercosur band. `argentina_2016__Mercosur_-B`: a deep blue, not the flag's.
  static const Color mercosurBlue = Color(0xFF04489F);

  static const Color mercosurWhite = Color(0xFFFBFBFB);

  static const Color black = Color(0xFF1A1A1A);

  /// 1995 series black plate and trailer band. `NVZ_087`.
  static const Color legacyBlack = Color(0xFF0A0A0A);
  static const Color legacyInk = Color(0xFFF6F6F6);

  /// 1995 mission plates' blue band. `A004DCM`, `C905DMP`, ...
  static const Color missionBlue = Color(0xFF2393F5);

  /// The grey face around a 1995 band and the caption ink on it.
  static const Color missionFace = Color(0xFFEBEBEB);
  static const Color missionCaption = Color(0xFF6BBAD5);
  static const Color white = Color(0xFFFFFFFF);

  /// Estimated: the rim of the 1995 plates is a bevel, sampled as light grey.
  static const Color rim = Color(0xFF9A9A9A);

  /// 1985 foreign-mission field. `CC-7609`.
  static const Color teal = Color(0xFF90CEBF);
  static const Color red = Color(0xFFFF352D);

  /// 1985 diplomatic plate: black on near-white. `CD-0607`.
  static const Color diplomaticWhite = Color(0xFFF7F7F7);
  static const Color diplomaticInk = Color(0xFF0A0A0A);

  /// National flag stripes and Sun of May.
  static const Color flagBlue = Color(0xFF74ACDF);
  static const Color flagSun = Color(0xFFF6B40E);

  static const Color inactiveOnDark = Color(0xFF5A5A5A);
  static const Color inactiveOnLight = Color(0xFFB0B0B0);
}
