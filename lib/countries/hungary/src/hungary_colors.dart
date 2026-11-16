import 'package:flutter/widgets.dart';

/// The colours of the Hungarian plates, sampled from the flattened photos
/// (modal pixel of the region).
///
/// The 2022 plate is the clean template: field `F3F3F3`, ink `060707`, band
/// `0046B8`. The diplomatic field `0253A2` and ink `C1D3E1`, the staff plate's
/// red `A84838` on `E4E5D8` with its blue strip `1878C8`, and the slow-vehicle
/// red `B84054` are photographed colours and carry their photo's lighting.
/// The agricultural photo is a weathered grey-green plate; it is drawn in the
/// standard black on white rather than in its dirt. The flag's red and green
/// are read off the export plate's sticker (`B91E1A`, `167867`).
abstract final class HungaryColors {
  static const Color white = Color(0xFFF3F3F3);
  static const Color black = Color(0xFF060707);
  static const Color euroBlue = Color(0xFF0046B8);

  static const Color diplomaticField = Color(0xFF0253A2);
  static const Color diplomaticInk = Color(0xFFC1D3E1);

  static const Color staffField = Color(0xFFE4E5D8);
  static const Color staffInk = Color(0xFFA84838);
  static const Color staffStrip = Color(0xFF1878C8);

  static const Color slowInk = Color(0xFFB84054);

  static const Color flagRed = Color(0xFFB91E1A);
  static const Color flagGreen = Color(0xFF167867);
}
