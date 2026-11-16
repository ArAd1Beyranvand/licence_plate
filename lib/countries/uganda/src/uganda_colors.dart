import 'package:flutter/widgets.dart';

/// Modal pixels of the colour-balanced zones of the ambulance photograph
/// (`Uganda_ambulance_registration_plate`): field and ink are the brief's
/// `EFB702` / `CC430E`, so the field is a deep yellow and the ink a red-orange.
/// The flag stripes are the national flag's black, yellow and red.
abstract final class UgandaColors {
  static const Color yellow = Color(0xFFEFB702);
  static const Color red = Color(0xFFCC430E);

  static const Color flagBlack = Color(0xFF000000);
  static const Color flagYellow = Color(0xFFFCDC04);
  static const Color flagRed = Color(0xFFD90000);
}
