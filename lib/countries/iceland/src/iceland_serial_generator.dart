import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

import 'iceland_validators.dart';

/// Random values for fixtures and demos, one string per slot. A two-field
/// plate gets two letters and `123` or `C12` (a mission letter after `CD`, the
/// slot's own prefix on a dealer plate); a vanity plate gets two to six
/// characters.
abstract final class IcelandSerialGenerator {
  static const String _letters = 'ABCDEFGHIJKLMNOPRSTUVXYZ';

  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    String letter() => _letters[rnd.nextInt(_letters.length)];
    String digits(int n) =>
        List<String>.generate(n, (_) => '${rnd.nextInt(10)}').join();

    if (spec.slots.length == 1) {
      final PlateSlot slot = spec.slots.single;
      final int n =
          slot.minLength + rnd.nextInt(slot.length - slot.minLength + 1);
      return <String?>[List<String>.generate(n, (_) => letter()).join()];
    }
    final String prefix = spec.slots.first.alphabet.characters.length == 2
        ? spec.slots.first.alphabet.characters.join()
        : letter() + letter();
    final String serial = switch (prefix) {
      'CD' =>
        IcelandMissions.names.keys.elementAt(
              rnd.nextInt(IcelandMissions.names.length),
            ) +
            digits(2),
      'RN' => digits(3),
      _ => rnd.nextBool() ? digits(3) : letter() + digits(2),
    };
    return <String?>[prefix, serial];
  }
}
