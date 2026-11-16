import 'package:flutter/widgets.dart';

/// The colours of the North Macedonian plates, sampled from the flattened
/// vector plates (Demir Kapija, Skopje, Kavadarci) by the offline stage.
///
/// White field, black ink and frame. The side band is `255DE6` and the
/// emblem block `ED1C24` (modal pixels of the SVG artwork; the photographed
/// two-row plates read a darker `005CA1` and `B42D26` from their lighting, so
/// they are not used). The diplomatic plate is a dark photo whose field reads
/// `7E6A65` / `838486` through glare; the article says black, and the ink
/// reads `FDFBF6`.
abstract final class NorthMacedoniaColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color band = Color(0xFF255DE6);
  static const Color emblem = Color(0xFFED1C24);
  static const Color diplomaticInk = Color(0xFFFDFBF6);
}
