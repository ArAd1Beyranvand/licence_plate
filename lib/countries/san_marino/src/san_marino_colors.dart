import 'package:flutter/widgets.dart';

/// The colours of the San Marino plates, modal pixels of the flattened
/// reference photos (`.plateref/sm/photos.json`) except where noted.
///
/// The article gives RAL 5017 for the 2023 serial; the photos are the older
/// light-blue series, so the sampled `1B73BB` is used, not the RAL.
abstract final class SanMarinoColors {
  static const Color field = Color(0xFFF0EEED);
  static const Color fieldGrey = Color(0xFFDAD2C6);
  static const Color fieldElectric = Color(0xFFC1C0C7);
  static const Color fieldDiplomatic = Color(0xFFF1EBEB);

  static const Color blue = Color(0xFF1B73BB);
  static const Color blueTrailer = Color(0xFF4781CC);
  static const Color blueLight = Color(0xFF81B6D4);
  static const Color bluePolice = Color(0xFF70A5C5);
  static const Color green = Color(0xFF4C6939);
  static const Color black = Color(0xFF0C080D);

  static const Color redTrailer = Color(0xFFB62F35);
  static const Color redExport = Color(0xFFC6302A);

  /// The pink-red of the `CD` photo. Also used for `CRS` and `POLIZIA`,
  /// whose photos are too washed out to sample on their own — an estimate.
  static const Color redLight = Color(0xFFFF717E);
}
