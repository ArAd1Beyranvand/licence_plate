import 'package:license_plate/core/plate_core.dart';

/// Judges a 1976 car plate: a class letter and four digits (`P-0000`). Reports,
/// never bars a keystroke.
class ElSalvadorValidator extends RuledPlateValidator {
  const ElSalvadorValidator();

  static const String reasonLetter = 'The class is one letter.';
  static const String reasonSerial = 'The number is four digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('letter', r'[A-Z]', reasonLetter),
    PlateCheck('serial', r'[0-9]{4}', reasonSerial),
  ];
}

/// Judges a 1976 motorcycle plate: a letter, one digit and three digits
/// (`M-1-234`).
class ElSalvadorMotorcycleValidator extends RuledPlateValidator {
  const ElSalvadorMotorcycleValidator();

  static const String reasonLetter = 'The class is one letter.';
  static const String reasonSeries = 'The series is one digit.';
  static const String reasonSerial = 'The number is three digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('letter', r'[A-Z]', reasonLetter),
    PlateCheck('series', r'[0-9]{1}', reasonSeries),
    PlateCheck('serial', r'[0-9]{3}', reasonSerial),
  ];
}
