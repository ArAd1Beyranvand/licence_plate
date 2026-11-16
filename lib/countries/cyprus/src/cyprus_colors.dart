import 'package:flutter/widgets.dart';

/// The colours of the Republic of Cyprus's plates.
///
/// [euroBlue], [white], [yellow] and [black] are the modal pixels of the
/// vector artwork (`Cyprus_license_plate_2013_sample`, `..._KQL-343`).
/// [dealerRed] is the median of the red strokes in the dealer plate photo and
/// carries its fading. [rentalRed] is NOT sampled: the article says "dark red"
/// and the only photo is the pre-2013 plate.
abstract final class CyprusColors {
  static const Color euroBlue = Color(0xFF003399);
  static const Color white = Color(0xFFFFFFFF);
  static const Color yellow = Color(0xFFFFCC00);
  static const Color black = Color(0xFF000000);

  static const Color dealerRed = Color(0xFFC56056);
  static const Color rentalRed = Color(0xFF9E1B24); // CALIBRATE
}
