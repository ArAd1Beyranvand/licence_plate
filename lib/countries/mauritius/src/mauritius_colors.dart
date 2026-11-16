import 'package:flutter/widgets.dart';

/// Colours of Mauritius's government plate, from the colour-balanced flat of
/// `MAURITIUS_government_license_plate_-_Flickr_-_woody1778a` (`.plateref/mu`).
/// One photo, so no spread is known.
abstract final class MauritiusColors {
  /// Near-black with a purple cast.
  static const Color black = Color(0xFF16111B);

  /// The raised, silver-grey characters.
  static const Color silver = Color(0xFFC5BDAF);

  /// The "MAURITIUS" badge ground at the top: `50506C` (modal pixel of the
  /// zone crop).
  static const Color badge = Color(0xFF50506C);

  /// Badge lettering, estimated from the crop (too small to sample).
  static const Color badgeText = Color(0xFFC8CCE0);

  static const Color inactive = Color(0xFF6B6B6B);
}
