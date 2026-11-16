import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

/// Generates plausible values for fixtures and demos. Pure Dart.
///
/// Fills every text group of a Morocco spec with one string per slot: digits
/// of a random length between the slot's `minLength` and `length`, never all
/// zeros, and a series letter from the issued alphabet.
abstract final class MoroccoSerialGenerator {
  static const String _series = 'ABDHETY';

  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    final List<String?> values = List<String?>.filled(spec.slots.length, null);
    for (final PlateTextGroup group in spec.textGroups) {
      for (final int i in group.indices) {
        final PlateSlot slot = spec.slots[i];
        if (group.key == 'series') {
          values[i] = _series[rnd.nextInt(_series.length)];
          continue;
        }
        final int count =
            slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1);
        final String digits = List<String>.generate(
          count,
          (_) => rnd.nextInt(10).toString(),
        ).join();
        values[i] = digits.replaceAll('0', '').isEmpty
            ? '${'0' * (count - 1)}1'
            : digits;
      }
    }
    return values;
  }
}
