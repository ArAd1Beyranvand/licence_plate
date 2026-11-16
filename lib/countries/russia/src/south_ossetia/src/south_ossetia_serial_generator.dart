import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

/// Plausible values for fixtures and demos, one string per slot.
abstract final class SouthOssetiaSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String>[
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
