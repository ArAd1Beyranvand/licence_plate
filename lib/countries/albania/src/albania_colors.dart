import 'package:flutter/widgets.dart';

/// Sampled from the flattened, colour-balanced references
/// (`.plateref/al/sheet_flat.png`): the modal colour of each region, so they
/// carry the photos' lighting to a few steps.
abstract final class AlbaniaColors {
  /// The national strip on the left and the sticker strip on the right: the
  /// zone colour on every plate.
  static const Color blue = Color(0xFF003399);

  static const Color white = Color(0xFFFFFFFF);

  static const Color black = Color(0xFF000000);

  /// Agricultural, technological and trailer field. `Agricultural_Vehicle`.
  static const Color green = Color(0xFF3C875D);

  /// Taxi field. `Taxi`.
  static const Color yellow = Color(0xFFFFC913);

  /// Ink and frame of the repetitive, taxi, temporary and test plates.
  static const Color red = Color(0xFFD8272D);

  /// Police ink and frame. `Police_vehicle`: a dark navy, not the strip's blue.
  static const Color policeBlue = Color(0xFF000066);

  /// The security hologram between the series and the number, flattened to
  /// one grey (it is a photographic seal on the plate).
  static const Color hologram = Color(0xFFBDB8AA);

  static const Color inactiveOnDark = Color(0xFF5A5A5A);
  static const Color inactiveOnLight = Color(0xFFB0B0B0);
}
