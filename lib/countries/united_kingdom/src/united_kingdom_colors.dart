import 'package:flutter/widgets.dart';

/// Sampled from the Wikipedia artwork (`UK_Rear_Registration_Plate`,
/// `UK_ZEV_*`, the nation-band plates) and, for the silver and trade inks,
/// from the photographs of real plates.
abstract final class UnitedKingdomColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color rearYellow = Color(0xFFFFCC00);

  static const Color zevGreen = Color(0xFF00B74F);

  /// Nation band, pre-2021 blue.
  static const Color bandBlue = Color(0xFF020299);

  /// Silver characters on a pre-1980 black plate, from the photograph.
  static const Color silver = Color(0xFF9C9188);

  /// Trade-plate characters, from the photograph.
  static const Color tradeRed = Color(0xFFDB3125);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0x80FFFFFF);
}
