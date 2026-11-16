import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

import 'russia_missions.dart';
import 'russia_plates.dart';
import 'russia_regions.dart';

/// Plausible values for fixtures and demos, one string per slot. The region is
/// a known code (a formation code on a military plate) and a diplomatic number
/// is one digit after `CD`, three after `D` or `T`.
abstract final class RussiaSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    final List<String> values = <String>[
      for (final PlateSlot slot in spec.slots) _run(slot, rnd),
    ];
    final int last = values.length - 1;
    if (spec.id == RussiaPlates.diplomatic.id) {
      final List<String> missions = <String>[
        for (final String code in RussiaMissions.all.keys)
          if (!RussiaMissions.isRefused(code)) code,
      ];
      values[0] = missions[rnd.nextInt(missions.length)];
      final int digits = values[1] == 'CD' ? 1 : 3;
      values[2] = values[2].padRight(digits, '1').substring(0, digits);
    }
    final List<String> codes = spec.id == RussiaPlates.military.id
        ? RussiaRegions.militaryCodes.toList()
        : RussiaRegions.codes.toList();
    values[last] = codes[rnd.nextInt(codes.length)];
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
