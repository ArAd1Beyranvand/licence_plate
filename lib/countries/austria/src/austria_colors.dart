import 'package:flutter/widgets.dart';

/// The colours of the Austrian plates, sampled from the flattened photos
/// (modal pixel of the region).
///
/// The white/black of the ordinary plate, the euroband `003399` and the
/// triband red `DB1B22` are read off the vector-clean `S 578 IL` flat. The
/// other fields and inks are the brief's colour-balanced values for each
/// photo. The red of the temporary plate's year strip was not sampled: it
/// reuses the trailer plate's red.
abstract final class AustriaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color euroBlue = Color(0xFF003399);
  static const Color stripeRed = Color(0xFFDB1B22);

  static const Color electricInk = Color(0xFF45804D);

  static const Color exportField = Color(0xFF28D0C6);
  static const Color exportInk = Color(0xFFF6F6F6);

  static const Color trailerField = Color(0xFFC8141C);
  static const Color trailerInk = Color(0xFFF4F3F4);

  static const Color temporaryField = Color(0xFF59A1DA);
  static const Color temporaryInk = Color(0xFFF9F1EC);

  static const Color mopedField = Color(0xFFB33441);
  static const Color mopedInk = Color(0xFFF6F4EF);
}
