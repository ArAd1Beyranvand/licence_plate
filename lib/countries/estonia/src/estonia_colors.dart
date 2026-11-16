import 'package:flutter/widgets.dart';

/// Colours sampled as the modal pixel of each flattened reference.
abstract final class EstoniaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color euBlue = Color(0xFF003399);
  static const Color euInk = Color(0xFFFFFFFF);

  /// Diplomatic plate: white on blue, with the panel a darker blue.
  static const Color diplomaticField = Color(0xFF0457A3);
  static const Color diplomaticInk = Color(0xFFF5FCFE);
  static const Color diplomaticPanel = Color(0xFF0A3481);

  /// Defence Forces plate: light grey on slate.
  static const Color defenceField = Color(0xFF4D5870);
  static const Color defenceInk = Color(0xFFF5F5F8);

  /// President's plate: a grey-white field; the frame is a dark grey sampled
  /// from the photograph's edge.
  static const Color presidentField = Color(0xFFF2F1F4);
  static const Color presidentFrame = Color(0xFF1E2024);
}
