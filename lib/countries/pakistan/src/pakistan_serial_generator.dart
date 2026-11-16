import 'dart:math';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

/// Random values for fixtures and demos: one string per slot, a random
/// length between a variable slot's `minLength` and `length`.
abstract final class PakistanSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String?>[
      for (final PlateSlot slot in spec.slots)
        List<String>.generate(
          slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1),
          (_) => slot.alphabet.id == PakistanAlphabets.letters.id
              ? PakistanAlphabets.letters.characters[rnd.nextInt(
                  PakistanAlphabets.letters.characters.length,
                )]
              : '${rnd.nextInt(10)}',
        ).join(),
    ];
  }
}
