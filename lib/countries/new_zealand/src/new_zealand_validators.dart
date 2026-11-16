import 'package:license_plate/core/plate_core.dart';

/// Judges a standard plate: three letters and three digits (`ABC 123`).
/// Reports, never bars a keystroke.
class NewZealandValidator extends RuledPlateValidator {
  const NewZealandValidator();

  static const String reasonLetters = 'The letters are three capitals.';
  static const String reasonSerial = 'The number is three digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('letters', r'[A-Z]{3}', reasonLetters),
    PlateCheck('serial', r'[0-9]{3}', reasonSerial),
  ];
}

/// Judges the older plate: two letters and four digits (`GG 9094`).
class NewZealandLegacyValidator extends RuledPlateValidator {
  const NewZealandLegacyValidator();

  static const String reasonLetters = 'The letters are two capitals.';
  static const String reasonSerial = 'The number is four digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('letters', r'[A-Z]{2}', reasonLetters),
    PlateCheck('serial', r'[0-9]{4}', reasonSerial),
  ];
}

/// Judges a personalised plate: one to six letters and digits, one field.
class NewZealandPersonalisedValidator extends GatedPlateValidator {
  const NewZealandPersonalisedValidator() : super('serial');

  static final RegExp _run = RegExp(r'^[A-Z0-9]{1,6}$');

  static const String reasonRun =
      'A personalised plate is one to six letters or digits.';

  @override
  PlateValidation judge(PlateEntry entry) =>
      _run.hasMatch(entry.group('serial'))
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reasonRun);
}
