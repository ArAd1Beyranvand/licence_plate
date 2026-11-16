import 'package:flutter/widgets.dart';

/// The colours of the 2018 Honduran plate, sampled from the flattened photo
/// (the modal colour of each region, `platekit`).
abstract final class HondurasColors {
  /// Top band and the `CENTROAMÉRICA` caption: `003399`.
  static const Color blue = Color(0xFF003399);

  static const Color white = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF000000);

  /// The flag's own blue, from the Commons SVG (`0d3b99`).
  static const Color flagBlue = Color(0xFF0D3B99);
}
