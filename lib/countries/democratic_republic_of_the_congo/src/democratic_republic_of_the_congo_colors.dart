import 'package:flutter/widgets.dart';

/// Colours of the DRC plates. The private plate and the flag are sampled from
/// the flattened artwork (`Plaque_d_immatriculation_en_RD_du_Congo`); the
/// others are modal colours of photographs, so each is marked `// CALIBRATE`.
abstract final class DemocraticRepublicOfTheCongoColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// Flag, from the artwork: sky blue, red and yellow.
  static const Color flagBlue = Color(0xFF037FFF);
  static const Color flagRed = Color(0xFFCE1021);
  static const Color flagYellow = Color(0xFFF6D517);

  /// Hologram strip before the area code, artwork.
  static const Color hologram = Color(0xFFD6D6D6);

  /// International organisation and police field: dark blue, photographs.
  static const Color navy = Color(0xFF14345C); // CALIBRATE

  /// White ink on the organisation plate, photograph.
  static const Color paleWhite = Color(0xFFF4F4F4); // CALIBRATE

  /// Police digits: worn orange on the blue, photograph.
  static const Color policeOrange = Color(0xFFE0A030); // CALIBRATE

  /// FARDC field and ink, from the flattened photo.
  static const Color armyField = Color(0xFF323027); // CALIBRATE
  static const Color armyInk = Color(0xFFF1F2F5); // CALIBRATE

  /// Diplomatic field and ink. The article says red on yellow; the photograph
  /// is orange with dark digits and the photograph wins.
  static const Color diplomaticField = Color(0xFFD4742C); // CALIBRATE
  static const Color diplomaticInk = Color(0xFF422F27); // CALIBRATE

  /// United Nations plate, photograph.
  static const Color unField = Color(0xFFE8E8E8); // CALIBRATE
  static const Color unInk = Color(0xFF252527); // CALIBRATE

  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
