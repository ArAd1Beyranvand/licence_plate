import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

/// Judges a 2011-series plate (`ABC 123 MC`): three letters, three digits and
/// a province code. Reports, never bars a keystroke.
class MozambiqueValidator extends GatedPlateValidator {
  const MozambiqueValidator() : super('number');

  static const String reasonLetters = 'The series is three letters.';
  static const String reasonNumber = 'The number is three digits.';
  static const String reasonProvince =
      'The province is CA, GZ, IB, MC, MP, MN, NP, NS, SF, TT or ZB.';

  static final RegExp _letters = RegExp(r'^[A-Z]{3}$');

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_letters.hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (!isDigitsOfLength(entry.group('number'), 3)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (!MozambiqueAlphabets.provinceCodes.contains(entry.group('province'))) {
      return const PlateValidation.invalid(reasonProvince);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a pre-2011 plate (`MLY 01-81`): an `M`, two district letters and two
/// pairs of digits.
class MozambiqueLegacyValidator extends GatedPlateValidator {
  const MozambiqueLegacyValidator() : super('first');

  static const String reasonLetters =
      'The series is M and two district letters.';
  static const String reasonDigits = 'The number is two pairs of digits.';

  static final RegExp _letters = RegExp(r'^M[A-Z]{2}$');

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_letters.hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (!isDigitsOfLength(entry.group('first'), 2) ||
        !isDigitsOfLength(entry.group('second'), 2)) {
      return const PlateValidation.invalid(reasonDigits);
    }
    return const PlateValidation.valid();
  }
}
