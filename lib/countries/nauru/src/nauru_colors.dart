import 'package:flutter/widgets.dart';

/// The colours of Nauru's plates, each sampled from one flattened photo
/// (stroke interiors, white-balanced). One photo per plate cannot separate
/// paint from light, so treat them as close, not exact.
abstract final class NauruColors {
  /// 1970–75 field. `NAURU_1970s_passenger_license_plate`: `110C11`.
  static const Color classicField = Color(0xFF110C11);

  /// Its ink, same photo: `E6DDD2`.
  static const Color classicInk = Color(0xFFE6DDD2);

  /// 1975–2015 field. `NAuru_7827`: `EBE4E2`.
  static const Color legacyField = Color(0xFFEBE4E2);

  /// Its ink, same photo: `241A24`.
  static const Color legacyInk = Color(0xFF241A24);

  /// 2015– field. `Nauru_AAA-595`: `DEDEDC`.
  static const Color field = Color(0xFFDEDEDC);

  /// Its ink, same photo: `3F403A`.
  static const Color ink = Color(0xFF3F403A);
}
