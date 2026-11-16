import 'package:flutter/widgets.dart';

/// The colours of Panama's 2006–2018 plates.
///
/// Every value is the median of a flattened, white-balanced photo
/// (`tools/platekit`), so glare and wear on the embossed paint lift the inks.
/// The 2016 band was sampled from `2016_Panama_License_Plate` directly.
abstract final class PanamaColors {
  /// 2016 car face: `D6C5C7`. Ink `302A29`.
  static const Color white = Color(0xFFD6C5C7);
  static const Color black = Color(0xFF302A29);

  /// The sky-blue band across the top of the 2016 plate, `30A8F0`.
  static const Color band = Color(0xFF30A8F0);

  /// Motorcycle (2018) face `D0D0D1`, ink `3C383E`, and its grey-green caption
  /// band `B0B4A4`.
  static const Color motoWhite = Color(0xFFD0D0D1);
  static const Color motoBlack = Color(0xFF3C383E);
  static const Color motoBand = Color(0xFFB0B4A4);

  /// 2008 car: field `D6D1C5`, ink `130D12`.
  static const Color cream = Color(0xFFD6D1C5);
  static const Color creamInk = Color(0xFF130D12);
}
