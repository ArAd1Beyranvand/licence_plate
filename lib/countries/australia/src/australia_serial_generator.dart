import 'dart:math';

import 'package:license_plate/core/plate_core.dart';

import 'australia_formats.dart';

/// Random values for fixtures and demos: one string per slot, a random length
/// between the field's minimum and maximum.
abstract final class AustraliaSerialGenerator {
  static List<String?> generate(PlateSpec spec, {Random? random}) {
    final Random rnd = random ?? Random();
    final List<AustraliaField> fields =
        AustraliaFormats.bySpecId[spec.id] ?? const <AustraliaField>[];
    return <String?>[for (final AustraliaField f in fields) f.random(rnd)];
  }
}
