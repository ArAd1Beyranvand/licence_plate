import 'package:flutter/widgets.dart';

/// Field and ink of each Belizean series: the modal colour of the plate region
/// in the flattened references (`tools/platekit`), not the article's words.
/// [white] and [black] are the clean artwork (`Belize_license_plate_graphic.png`,
/// FFFFFF / 000000); the rest are photographs of weathered plates and are
/// `// CALIBRATE`. The article calls the passenger plates white; the grey of
/// the city and twin-town photographs is age and lighting, so they use [white].
abstract final class BelizeColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// Auto dealer: black on a (faded) orange.
  static const Color dealerField = Color(0xFFC66E47); // CALIBRATE
  static const Color dealerInk = Color(0xFF1C101B); // CALIBRATE

  /// Agricultural and commercial trucks: white on black.
  static const Color truckField = Color(0xFF3B3032); // CALIBRATE
  static const Color truckInk = Color(0xFFEBE8E5); // CALIBRATE

  /// Defence ministry: white on brown.
  static const Color defenceField = Color(0xFF481F21); // CALIBRATE
  static const Color defenceInk = Color(0xFFEAF2E6); // CALIBRATE

  /// Taxis and public service: white on dark green.
  static const Color taxiField = Color(0xFF346E64); // CALIBRATE
  static const Color taxiInk = Color(0xFFDCC9C5); // CALIBRATE

  /// Flag blue, from `Flag_of_Belize.svg`.
  static const Color flagBlue = Color(0xFF171696);

  static const Color inactiveOnDark = Color(0xFF5A5A5A);
  static const Color inactiveOnLight = Color(0xFFB0B0B0);
}
