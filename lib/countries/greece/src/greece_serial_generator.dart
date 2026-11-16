import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

import 'greece_plates.dart';

/// Generates plausible values for fixtures and demos: one string per slot, of
/// random length between its `minLength` and `length`; a private car's number
/// stays in 1000–9999.
abstract final class GreeceSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String?>[
      for (final PlateSlot slot in spec.slots)
        _run(slot, rnd, spec.id == GreecePlates.private.id),
    ];
  }

  static String _run(PlateSlot slot, Random rnd, bool privateCar) {
    final int n =
        slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1);
    final List<String> chars = slot.alphabet.characters;
    final String run = List<String>.generate(
      n,
      (_) => chars[rnd.nextInt(chars.length)],
    ).join();
    if (privateCar && slot.alphabet.isNumeric) {
      return '${1 + rnd.nextInt(9)}${run.substring(1)}';
    }
    return run;
  }
}
