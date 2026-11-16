import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

import 'transnistria_regions.dart';

/// Plausible values for fixtures and demos, one string per slot. A `region`
/// field is a known letter.
abstract final class TransnistriaSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    final List<String> codes = TransnistriaRegions.codes
        .where((c) => c != 'H')
        .toList();
    return <String>[
      for (int i = 0; i < spec.slots.length; i++)
        if (spec.textGroups[i].key == 'region')
          codes[rnd.nextInt(codes.length)]
        else
          _run(spec.slots[i], rnd),
    ];
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
