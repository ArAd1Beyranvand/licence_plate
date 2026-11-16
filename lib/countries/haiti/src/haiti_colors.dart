import 'package:flutter/widgets.dart';

/// The colours a Haitian plate is printed in, from the measured references
/// (`tools/platekit` flattens each photo and balances its colour). Plates are
/// old and weathered; values from photographs are marked `// CALIBRATE`.
abstract final class HaitiColors {
  /// 2014 passenger-transport field, `Haitian_2014_series_..._plate.jpg`.
  static const Color salmon = Color(0xFFD2A499);
  static const Color salmonInk = Color(0xFF222020);

  /// Red stacked "HAITI" on the 2014 plate. CALIBRATE
  static const Color salmonRed = Color(0xFFB45454);

  /// 2006 regional field and its dark green ink, `Haiti_2010_License_Plate.jpg`.
  static const Color grey = Color(0xFFC4C5C9);
  static const Color greenInk = Color(0xFF162622);

  /// The light blue "HAÏTI" on the 2006 plate (the photo's zone 35749C).
  static const Color lightBlue = Color(0xFF35749C);

  /// 2003 white field and its navy ink, `..._TRANSPORT_PASSAGERS_plate.jpg`.
  static const Color white = Color(0xFFD4C9B8);
  static const Color navy = Color(0xFF1A193A);

  /// The pale grey "HAÏTI" at the top of a 2003 plate. CALIBRATE
  static const Color paleGrey = Color(0xFFA0A8B8);

  /// 1998 field and red ink, `..._TAXI_plate.jpg`.
  static const Color cream = Color(0xFFCDC9BD);
  static const Color red = Color(0xFF9B312A);

  /// The 1998 captions' blue (the photo's zone 2B3E82).
  static const Color captionBlue = Color(0xFF2B3E82);

  /// Flag blue and red, from `Flag_of_Haiti.svg`.
  static const Color flagBlue = Color(0xFF00209F);
  static const Color flagRed = Color(0xFFD21034);

  static const Color caption = Color(0xFFFFFFFF);
  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
