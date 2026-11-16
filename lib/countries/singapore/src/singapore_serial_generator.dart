import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

import 'singapore_validators.dart';

/// Random values for fixtures and demos: one string per slot, a prefix from
/// consonants of one to [PlateSlot.length] letters ([prefix] overrides it), a serial of one to four digits and the matching checksum.
abstract final class SingaporeSerialGenerator {
  static const String _prefixLetters = 'BCDFGHJKLMPRSTXYZ';

  static List<String?> generate(
    PlateSpec spec, {
    Random? random,
    String? prefix,
  }) {
    final Random rnd = random ?? Random();
    final PlateSlot prefixSlot =
        spec.slots[spec.indicesOfGroup('prefix').single];
    final String p =
        prefix ??
        List<String>.generate(
          prefixSlot.minLength +
              rnd.nextInt(prefixSlot.length - prefixSlot.minLength + 1),
          (_) => _prefixLetters[rnd.nextInt(_prefixLetters.length)],
        ).join();
    final int digits = 1 + rnd.nextInt(4);
    final String serial =
        '${1 + rnd.nextInt(9)}${List<String>.generate(digits - 1, (_) => '${rnd.nextInt(10)}').join()}';
    final Map<String, String> byKey = <String, String>{
      'prefix': p,
      'serial': serial,
      'check': SingaporeChecksum.of(p, serial) ?? '',
    };
    return <String?>[
      for (final PlateSlot slot in spec.slots)
        byKey[spec.groupAt(spec.slots.indexOf(slot))?.key],
    ];
  }
}
