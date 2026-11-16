import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

/// Random values for fixtures and demos: one string per field, of a random
/// length between the field's minimum and maximum.
abstract final class PolandSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String?>[
      for (final PlateSlot slot in spec.slots) _field(slot, rnd),
    ];
  }

  static String _field(PlateSlot slot, Random rnd) {
    final int count =
        slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1);
    final List<String> chars = slot.alphabet.characters;
    return List<String>.generate(
      count,
      (_) => chars[rnd.nextInt(chars.length)],
    ).join();
  }
}
