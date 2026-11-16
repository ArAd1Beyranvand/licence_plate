import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

import 'abkhazia_plates.dart';

/// Plausible values for fixtures and demos, one string per slot. A diplomatic
/// number is one digit after `CD`, three after `D` or `T`.
abstract final class AbkhaziaSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    final List<String> values = <String>[
      for (final PlateSlot slot in spec.slots) _run(slot, rnd),
    ];
    if (spec.id == AbkhaziaPlates.diplomatic.id) {
      final int digits = values[1] == 'CD' ? 1 : 3;
      values[2] = values[2].padRight(digits, '1').substring(0, digits);
    }
    return values;
  }

  static String _run(PlateSlot slot, Random rnd) {
    final int n =
        slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1);
    final List<String> chars = slot.alphabet.characters;
    return List<String>.generate(
      n,
      (_) => chars[rnd.nextInt(chars.length)],
    ).join();
  }
}
