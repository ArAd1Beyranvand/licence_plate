import 'package:flutter/widgets.dart';

/// The colours of the Croatian plates.
///
/// Private, customized and classic plates use the clean artwork
/// (`Kroatisches_Kennzeichen`): ink `242126` on white. The euroband `033FA2` is
/// the EU flag's blue as `slovenia_plate` uses it. The special plates are
/// sampled from photographs (modal pixel of the flattened region, balanced by
/// the brief) and carry their photo's lighting: army `FFE107`/`5E574A`, export
/// `02F6CA`/`EE8B06`, oversize `CEDDD2`/`A9675C` (the article says red ink; the
/// photo is faded), police ink `040C3F` on white (the photo's grey field is
/// lighting; the article says blue on white), diplomatic `06C5E7`/`FFE3A8`.
/// The pinstripe red and blue are read off the artwork's edge lines.
abstract final class CroatiaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF242126);
  static const Color euroBlue = Color(0xFF033FA2);

  static const Color stripeRed = Color(0xFFC8454E);
  static const Color stripeBlue = Color(0xFF2B3E8F);

  static const Color armyYellow = Color(0xFFFFE107);
  static const Color armyInk = Color(0xFF5E574A);

  static const Color exportField = Color(0xFF02F6CA);
  static const Color exportInk = Color(0xFFEE8B06);

  static const Color oversizeField = Color(0xFFCEDDD2);
  static const Color oversizeInk = Color(0xFFA9675C);

  static const Color policeInk = Color(0xFF040C3F);

  static const Color diplomaticField = Color(0xFF06C5E7);
  static const Color diplomaticInk = Color(0xFFFFE3A8);
}
