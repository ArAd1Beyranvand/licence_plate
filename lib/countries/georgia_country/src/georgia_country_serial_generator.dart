import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

/// Random values for fixtures and demos: one string per slot, of a random
/// length from the slot's `minLength` to its `length`. A draw that breaks the
/// spec's restrictions (the refused embassy code) is drawn again.
abstract final class GeorgiaCountrySerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    List<String?> draw() => <String?>[
      for (final PlateSlot slot in spec.slots)
        () {
          final int n =
              slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1);
          final List<String> chars = slot.alphabet.characters;
          return List<String>.generate(
            n,
            (_) => chars[rnd.nextInt(chars.length)],
          ).join();
        }(),
    ];

    List<String?> values = draw();
    while (spec.restrictionViolatedBy(values) != null) {
      values = draw();
    }
    return values;
  }
}
