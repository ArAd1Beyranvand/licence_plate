import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

/// Random values for fixtures and demos: one string per slot, of a random
/// length between the slot's `minLength` and `length`.
abstract final class HaitiSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String?>[
      for (final PlateSlot slot in spec.slots)
        List<String>.generate(
          slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1),
          (_) =>
              slot.alphabet.characters[rnd.nextInt(
                slot.alphabet.characters.length,
              )],
        ).join(),
    ];
  }
}
