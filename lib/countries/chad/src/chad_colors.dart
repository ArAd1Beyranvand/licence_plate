import 'package:flutter/widgets.dart';

/// The colours of the Chadian plates, sampled from the flattened photos.
abstract final class ChadColors {
  /// Regular field: `FEFEFE`.
  static const Color white = Color(0xFFFEFEFE);

  /// Regular ink. The photo's characters sample `000000`.
  static const Color black = Color(0xFF000000);

  /// Temporary field, a red: `D8303A`.
  static const Color red = Color(0xFFD8303A);

  /// Temporary ink, a grey-tinged white from the photo: `D0DEE3`.
  static const Color paintedWhite = Color(0xFFD0DEE3);
}
