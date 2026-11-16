import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

/// Generates plausible values for fixtures and demos, one string per slot.
abstract final class CanadaSerialGenerator {
  static const String _letters = 'ABCDEFGHJKLMNPRSTVWXYZ';

  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String?>[
      for (final PlateSlot slot in spec.slots)
        slot.alphabet == PlateAlphabet.latinDigits
            ? _digits(
                rnd,
                slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1),
              )
            : _letters[rnd.nextInt(_letters.length)],
    ];
  }

  static String _digits(Random rnd, int count) =>
      List<String>.generate(count, (_) => '${rnd.nextInt(10)}').join();
}
