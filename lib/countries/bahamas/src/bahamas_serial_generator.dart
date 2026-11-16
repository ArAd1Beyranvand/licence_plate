import 'dart:math';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

/// Generates plausible values for fixtures and demos: a digit run of random
/// length between the slot's `minLength` and `length`, and `T` for a letter
/// slot.
abstract final class BahamasSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String?>[
      for (final PlateSlot slot in spec.slots)
        if (slot.alphabet == BahamasAlphabets.letters)
          'T'
        else
          List<String>.generate(
            slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1),
            (_) => '${rnd.nextInt(10)}',
          ).join(),
    ];
  }
}
