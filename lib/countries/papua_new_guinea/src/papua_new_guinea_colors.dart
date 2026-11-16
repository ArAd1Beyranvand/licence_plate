import 'package:flutter/widgets.dart';

/// Fields and inks are the colour-balanced modal pixels of the flattened
/// references in `.plateref/pg`. Where only a photo of a weathered or
/// oddly lit plate exists, the entry says so.
abstract final class PapuaNewGuineaColors {
  /// General issue and motorcycles (BAA-000 fit). The measured ink 494E5F is
  /// the embossing catching light; the dark of the same design (B.set) is used.
  static const Color generalField = Color(0xFFEFEFEF);
  static const Color generalInk = Color(0xFF2C2F35);

  /// Taxi (Taxi_Set) and hire (H.set1) yellows, sampled separately.
  static const Color taxiField = Color(0xFFE3C509);
  static const Color taxiInk = Color(0xFF1B180D);
  static const Color hireField = Color(0xFFDECA01);
  static const Color hireInk = Color(0xFF232314);

  /// Trailer (Trailer_plate_Set).
  static const Color trailerField = Color(0xFF23C5AC);
  static const Color trailerInk = Color(0xFF132E32);

  /// Public motor vehicle: blue is "no set route", orange is buses.
  static const Color pmvBlueField = Color(0xFF3E9DCE);
  static const Color pmvBlueInk = Color(0xFF161712);
  static const Color pmvOrangeField = Color(0xFFFF995E);
  static const Color pmvOrangeInk = Color(0xFF1D101E);

  /// Diplomatic corps (Diplomatic_Corps fit).
  static const Color diplomaticField = Color(0xFF965260);
  static const Color diplomaticInk = Color(0xFFF6F8F2);

  /// Consular corps: black, white ink. Estimated from the CC-199 plate in the
  /// sheet; no measured row for it.
  static const Color consularField = Color(0xFF1E1F22);
  static const Color consularInk = Color(0xFFE8E8E6);

  /// Trade plates (TT-3447 fit): red on pale blue-grey.
  static const Color tradeField = Color(0xFFB1C6C8);
  static const Color tradeInk = Color(0xFF97191A);

  /// Government (G.Set field and ink); the red letters are estimated from the
  /// sheet.
  static const Color governmentField = Color(0xFFE2DED3);
  static const Color governmentInk = Color(0xFF1C1A16);
  static const Color governmentRed = Color(0xFFC8402F);

  /// Provincial government (PNG_P.set).
  static const Color provincialField = Color(0xFFCBD2BF);
  static const Color provincialInk = Color(0xFF2F2924);
}
