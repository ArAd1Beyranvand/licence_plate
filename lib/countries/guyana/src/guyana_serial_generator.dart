import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

/// Random values for fixtures and demos: one string per slot, a series of two
/// or three letters starting with [vehicleType] and a number of one to four
/// digits without a leading zero.
abstract final class GuyanaSerialGenerator {
  static List<String?> generate(
    PlateSpec spec, {
    Random? random,
    String vehicleType = 'P',
  }) {
    final Random rnd = random ?? Random();
    String letters(int n) =>
        vehicleType +
        String.fromCharCodes(
          List<int>.generate(n - 1, (_) => 0x41 + rnd.nextInt(26)),
        );
    String number(int n) =>
        '${1 + rnd.nextInt(9)}'
        '${List<String>.generate(n - 1, (_) => '${rnd.nextInt(10)}').join()}';
    return <String?>[
      for (final PlateSlot slot in spec.slots)
        slot.alphabet.isNumeric
            ? number(
                slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1),
              )
            : letters(
                slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1),
              ),
    ];
  }
}
