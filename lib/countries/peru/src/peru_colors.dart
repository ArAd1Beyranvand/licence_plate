import 'package:flutter/widgets.dart';

/// The colours of the 2010 Peruvian plates.
///
/// Sampled from the modal pixels of the clean category artwork on the
/// article's page (`Perú_*_license_plate_2010`, 170×87), field and ink by
/// region; the photographs only where the artwork is missing. Where two
/// categories sample to near-identical values they are kept as sampled
/// rather than merged.
abstract final class PeruColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// Truck, taxi header, temporary, large-motorcycle header, trailer body.
  static const Color yellow = Color(0xFFFFF700);

  /// Interprovincial-bus header, exhibition field.
  static const Color orange = Color(0xFFFF7900);

  /// City-bus header.
  static const Color busGreen = Color(0xFF0AD000);

  /// Police field.
  static const Color policeGreen = Color(0xFF0DCE01);

  /// Motorcycle field.
  static const Color cyan = Color(0xFF1FC5FF);

  /// Emergency field.
  static const Color red = Color(0xFFFE0000);

  /// Emergency ink, from the flattened photograph (the artwork is white).
  static const Color emergencyInk = Color(0xFFFCF0F0);

  /// Diplomatic ink and frame.
  static const Color diplomaticRed = Color(0xFFFD0000);

  /// Exhibition ink: black with a warm cast.
  static const Color exhibitionInk = Color(0xFF180000);

  /// Temporary-plate ink.
  static const Color temporaryBlue = Color(0xFF4068D4);

  /// Used-imported-vehicle ink.
  static const Color importedBlue = Color(0xFF4661D2);

  /// The stripes of the flag printed in the header.
  static const Color flagRed = Color(0xFFFE0000);
  static const Color flagWhite = Color(0xFFFFFFFD);

  /// The holographic label's face and the text on it.
  static const Color sticker = Color(0xFFD8D6D7);
  static const Color stickerInk = Color(0xFF252223);

  /// Input chrome only.
  static const Color inactive = Color(0xFFB0B0B0);
}
