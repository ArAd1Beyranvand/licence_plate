import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

import 'ecuador_validators.dart';

/// Random values for fixtures and demos, one string per slot: letters (a
/// province letter first on a standard plate, a protocol code on a protocol
/// plate) and a number of three or four digits.
abstract final class EcuadorSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    final List<String> provinces = EcuadorValidator.provinces.toList();
    final List<String> codes = EcuadorValidator.protocolCodes.toList();
    String letter() => String.fromCharCode(65 + rnd.nextInt(26));
    return <String?>[
      for (final PlateSlot slot in spec.slots)
        if (slot.alphabet == spec.slots.first.alphabet)
          spec.id == 'ec.protocol'
              ? codes[rnd.nextInt(codes.length)]
              : provinces[rnd.nextInt(provinces.length)] +
                    List<String>.generate(
                      slot.length - 1,
                      (_) => letter(),
                    ).join()
        else
          List<String>.generate(
            slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1),
            (_) => '${rnd.nextInt(10)}',
          ).join(),
    ];
  }
}
