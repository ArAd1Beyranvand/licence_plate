import 'package:flutter/widgets.dart';

/// The colours of the Marshall Islands' plates, each sampled from one flattened
/// picture (stroke interiors, white-balanced), so close rather than exact.
abstract final class MarshallIslandsColors {
  /// Majuro Atoll field. `Marshall_Islands_license_plate_graphic`: `477C3F`.
  static const Color field = Color(0xFF477C3F);

  /// Its ink, same picture: `FFFFFF`.
  static const Color ink = Color(0xFFFFFFFF);

  /// The grey sticker patch on the Majuro Atoll plate: `5C5C5C`.
  static const Color sticker = Color(0xFF5C5C5C);

  /// 1972 Trust Territory field. `TRUST_TERRITORY_…_1972_…woody1778a`: `D1C6B2`.
  static const Color trustField = Color(0xFFD1C6B2);

  /// Its ink, same photo: `131221`.
  static const Color trustInk = Color(0xFF131221);
}
