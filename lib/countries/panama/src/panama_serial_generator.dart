import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

/// Fills every slot of any `PanamaPlates` spec from its own alphabet: one
/// string per field, a random length between `minLength` and `length`.
abstract final class PanamaSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String?>[for (final PlateSlot slot in spec.slots) _fill(slot, rnd)];
  }

  static String _fill(PlateSlot slot, Random rnd) {
    final List<String> chars = slot.alphabet.characters;
    final int length =
        slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1);
    return List<String>.generate(
      length,
      (_) => chars[rnd.nextInt(chars.length)],
    ).join();
  }
}
