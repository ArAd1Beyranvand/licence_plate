import 'package:license_plate/core/plate_core.dart';

/// Judges a `CanadaPlates.federal` value: five digits. Reports, never bars a
/// keystroke.
class CanadaFederalValidator extends RuledPlateValidator {
  const CanadaFederalValidator();

  static const String reasonNumber = 'A federal plate has five digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('number', r'[0-9]{5}', reasonNumber),
  ];
}

/// Judges a `CanadaPlates.permit` value: a letter, then six digits. I, O, Q
/// and U are reported as unused.
class CanadaPermitValidator extends GatedPlateValidator {
  const CanadaPermitValidator() : super('letter');

  static const String reasonLetter = 'A permit starts with one letter.';
  static const String reasonUnused = 'I, O, Q and U are not used in serials.';
  static const String reasonNumber = 'A permit has six digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String letter = entry.group('letter');
    if (letter.length != 1) return const PlateValidation.invalid(reasonLetter);
    if ('IOQU'.contains(letter)) {
      return const PlateValidation.invalid(reasonUnused);
    }
    if (!isDigitsOfLength(entry.group('number'), 6)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}
