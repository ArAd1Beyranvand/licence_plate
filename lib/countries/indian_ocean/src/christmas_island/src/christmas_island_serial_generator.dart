import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

/// Random values for fixtures and demos: the register `CI` and four digits.
abstract final class ChristmasIslandSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    return <String?>[
      'CI',
      List<String>.generate(4, (_) => '${rnd.nextInt(10)}').join(),
    ];
  }
}
