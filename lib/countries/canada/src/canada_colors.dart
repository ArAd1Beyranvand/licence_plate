import 'package:flutter/widgets.dart';

/// Modal colour of a region of the flattened references:
/// `Canada_Federal_license_plate_78579` (colour-balanced photograph) and
/// `2004_Ontario_license_plate_10_day_permit` (scan). The maple leaf's red is
/// in `assets/icons/maple_leaf.*`.
abstract final class CanadaColors {
  static const Color federalField = Color(0xFFDEE2EB);

  /// Federal serial: a green so dark it reads as black.
  static const Color federalInk = Color(0xFF2A3434);

  /// Federal rim line and the word CANADA.
  static const Color federalGreen = Color(0xFF2C4C48);

  static const Color permitField = Color(0xFFF4F8FC);

  /// Permit serial: a dark grey, not black.
  static const Color permitInk = Color(0xFF484848);

  /// Permit rim and caption wording.
  static const Color permitBlue = Color(0xFF385494);

  static const Color inactive = Color(0xFFB0B0B0);
}
