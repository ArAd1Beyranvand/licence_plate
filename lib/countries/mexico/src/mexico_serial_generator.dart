import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

/// Generates plausible values for fixtures and demos. Pure Dart.
///
/// One string per slot, i.e. per field, drawn from the slot's own alphabet.
/// Mexico City's letters skip I, O and Q, which that series never issues;
/// they are dropped from every letter field, which every state also meets.
abstract final class MexicoSerialGenerator {
  static const String _skipped = 'IOQ';

  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String?>[
      for (final PlateSlot slot in spec.slots)
        () {
          final List<String> chars = <String>[
            for (final String c in slot.alphabet.characters)
              if (!_skipped.contains(c)) c,
          ];
          return List<String>.generate(
            slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1),
            (_) => chars[rnd.nextInt(chars.length)],
          ).join();
        }(),
    ];
  }
}
