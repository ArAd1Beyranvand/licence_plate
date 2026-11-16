import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

import 'romania_validators.dart';

/// Random values for fixtures and demos, one string per slot. The county is
/// random unless [county] is given; other fields are runs of random length.
const String _digits = '0123456789';
const String _letters = 'ABCDEFGHJKLMNPRSTUVWXYZ';

abstract final class RomaniaSerialGenerator {
  static List<String?> generate(
    PlateSpec spec, {
    Random? random,
    String? county,
  }) {
    final Random rnd = random ?? Random();
    String run(PlateSlot slot, String chars) {
      final int n =
          slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1);
      return List<String>.generate(
        n,
        (_) => chars[rnd.nextInt(chars.length)],
      ).join();
    }

    final String code =
        county ?? RomaniaCounties.names.keys.elementAt(rnd.nextInt(42));
    final List<String?> values = <String?>[];
    for (int i = 0; i < spec.slots.length; i++) {
      final PlateSlot slot = spec.slots[i];
      final String? key = spec.textGroups
          .where((g) => g.indices.contains(i))
          .map((g) => g.key)
          .firstOrNull;
      values.add(switch (key) {
        'county' => code,
        'letters' => run(slot, _letters),
        'code' => const <String>['CD', 'TC', 'CO'][rnd.nextInt(3)],
        'mission' || 'rank' => '${101 + rnd.nextInt(899)}',
        'number' when spec.id == 'ro.test' => '${101 + rnd.nextInt(899)}',
        'place' => 'TIMIȘOARA',
        _ when slot.alphabet.isNumeric => _number(spec, slot, code, rnd),
        _ => run(slot, _letters),
      });
    }
    return values;
  }

  static String _number(
    PlateSpec spec,
    PlateSlot slot,
    String county,
    Random rnd,
  ) {
    final bool standard = spec.id == 'ro.standard';
    final int n = standard
        ? (county == 'B' ? 2 + rnd.nextInt(2) : 2)
        : slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1);
    final List<String> d = List<String>.generate(
      n,
      (_) => _digits[rnd.nextInt(10)],
    );
    if (standard && d.every((c) => c == '0')) d[0] = '1';
    if (spec.id == 'ro.temporary') {
      d[0] = '0';
      d[1] = '${1 + rnd.nextInt(9)}';
    }
    return d.join();
  }
}
