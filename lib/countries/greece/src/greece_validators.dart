import 'package:license_plate/core/plate_core.dart';

import 'greece_plates.dart';

/// Judges a registration on any [GreecePlates] spec. Reports, never bars a
/// keystroke.
///
/// Checks, per field, the lengths the spec's slots declare (letters from the
/// fourteen Greek capitals that have a Latin twin, digits), and that a private
/// car's number runs 1000 to 9999.
class GreeceValidator extends GatedPlateValidator {
  const GreeceValidator() : super('number');

  static const String reasonLetters =
      'The prefix is letters from Α Β Ε Ζ Η Ι Κ Μ Ν Ο Ρ Τ Υ Χ.';
  static const String reasonDigits = 'The number has the wrong digit count.';
  static const String reasonRange = 'Private numbers run from 1000 to 9999.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final PlateSpec spec = entry.spec;
    final PlateSlot letters = spec.slots[spec.indicesOfGroup('letters').single];
    final PlateSlot number = spec.slots[spec.indicesOfGroup('number').single];
    final String prefix = entry.group('letters');
    final String digits = entry.group('number');
    if (prefix.length < letters.minLength ||
        prefix.length > letters.length ||
        !letters.accepts(prefix)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (!isDigits(digits) ||
        digits.length < number.minLength ||
        digits.length > number.length) {
      return const PlateValidation.invalid(reasonDigits);
    }
    if (spec.id == GreecePlates.private.id && int.parse(digits) < 1000) {
      return const PlateValidation.invalid(reasonRange);
    }
    return const PlateValidation.valid();
  }
}
