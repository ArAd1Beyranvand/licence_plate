import 'dart:math';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

/// Generates plausible values for fixtures and demos: one string per slot, a
/// random length between the slot's `minLength` and `length`.
abstract final class TrinidadAndTobagoSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String?>[
      for (final PlateSlot slot in spec.slots)
        List<String>.generate(
          slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1),
          (_) => slot.alphabet == TrinidadAndTobagoAlphabets.letters
              ? String.fromCharCode(65 + rnd.nextInt(26))
              : '${rnd.nextInt(10)}',
        ).join(),
    ];
  }
}
