import 'package:flutter/widgets.dart';

/// White, black and the euroband `003399` are the vector reference's own
/// (`Portuguese_licence_plate`); photographed white plates carry their
/// lighting, so they use the artwork's white. The diplomatic ink `DA2D30` and
/// the 1937 `3A4048` / `E7E9EA` are photograph samples balanced against the
/// field of the same photo.
///
/// The yellow ribbon `FFB800` is matched by eye against the US Forces artwork
/// and is an estimate.
abstract final class PortugalColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color euroBlue = Color(0xFF003399);
  static const Color ribbonYellow = Color(0xFFFFB800);

  static const Color diplomaticRed = Color(0xFFDA2D30);

  static const Color historicField = Color(0xFF3A4048);
  static const Color historicInk = Color(0xFFE7E9EA);
}
