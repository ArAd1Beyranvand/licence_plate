import 'package:flutter/widgets.dart';

/// Colours sampled from the flattened reference photos (`Ethiopia_License_plate20021`,
/// `…20261`, `…plateCD`), not read from the article.
abstract final class EthiopiaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// The ink of the regional and private plates (`27479F`, balanced to a white field).
  static const Color blue = Color(0xFF27479F);

  /// The diplomatic plate's two bands (`F6D80F`, the mode of both).
  static const Color yellow = Color(0xFFF6D80F);

  static const Color inactive = Color(0xFF9A9A9A);
}
