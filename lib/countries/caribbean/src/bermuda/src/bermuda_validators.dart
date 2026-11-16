import 'package:license_plate/core/plate_core.dart';

/// Judges a `BermudaPlates.private` value: five digits. Reports, never bars a
/// keystroke.
class BermudaValidator extends GatedPlateValidator {
  const BermudaValidator() : super('serial');

  static const String reasonSerial = 'The number is five digits.';

  @override
  PlateValidation judge(PlateEntry entry) =>
      isDigitsOfLength(entry.group('serial'), 5)
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reasonSerial);
}

/// Judges a `BermudaPlates.prefixed` value: one to three letters, then three
/// or four digits (`L1234`, `CL123`, `RMC001`).
class BermudaPrefixedValidator extends GatedPlateValidator {
  const BermudaPrefixedValidator() : super('serial');

  static const String reasonLetters =
      'The class prefix is one to three letters.';
  static const String reasonSerial = 'The number is three or four digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!RegExp(r'^[A-Z]{1,3}$').hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (!RegExp(r'^[0-9]{3,4}$').hasMatch(entry.group('serial'))) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a `BermudaPlates.suffixed` value: three digits and a letter
/// (`123Y`).
class BermudaSuffixedValidator extends RuledPlateValidator {
  const BermudaSuffixedValidator();

  static const String reasonSerial = 'The number is three digits.';
  static const String reasonLetter = 'The suffix is one letter.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('serial', r'[0-9]{3}', reasonSerial),
    PlateCheck('letter', r'[A-Z]', reasonLetter),
  ];
}
