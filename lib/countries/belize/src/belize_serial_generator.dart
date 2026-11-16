import 'dart:math';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

/// Generates plausible values for fixtures and demos: one string per slot,
/// either capitals of the slot's length or digits of a random length between
/// `minLength` and `length`.
abstract final class BelizeSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String?>[
      for (final PlateSlot slot in spec.slots)
        if (slot.alphabet == BelizeAlphabets.letters)
          String.fromCharCodes(
            List<int>.generate(slot.length, (_) => 0x41 + rnd.nextInt(26)),
          )
        else
          List<String>.generate(
            slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1),
            (_) => '${rnd.nextInt(10)}',
          ).join(),
    ];
  }
}
