import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

/// Random values for fixtures and demos, one string per slot. A field is
/// filled to a random length between its `minLength` and `length`; letters
/// come from [letters] when given (Greenland's `GR`, `GL`).
abstract final class DenmarkSerialGenerator {
  static const String _az = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  static List<String?> generate(
    PlateSpec spec, {
    Random? random,
    List<String> letters = const <String>[],
  }) {
    final Random rnd = random ?? Random();
    return <String?>[
      for (final PlateSlot slot in spec.slots) _fill(spec, slot, rnd, letters),
    ];
  }

  static String _fill(
    PlateSpec spec,
    PlateSlot slot,
    Random rnd,
    List<String> letters,
  ) {
    final bool isLetters =
        spec.groupAt(spec.slots.indexOf(slot))?.key == 'letters';
    if (isLetters && letters.isNotEmpty) {
      return letters[rnd.nextInt(letters.length)];
    }
    final int n =
        slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1);
    final String pool = isLetters || spec.slots.length == 1
        ? _az
        : '0123456789';
    return String.fromCharCodes(<int>[
      for (int i = 0; i < n; i++) pool.codeUnitAt(rnd.nextInt(pool.length)),
    ]);
  }
}
