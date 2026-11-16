import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

final RegExp _letters2 = RegExp(r'^[A-Z]{2}$');
final RegExp _letters3 = RegExp(r'^[A-Z]{3}$');

/// Judges a Mercosur plate (`AB 123 CD`). Reports, never bars a keystroke.
class ArgentinaStandardValidator extends GatedPlateValidator {
  const ArgentinaStandardValidator() : super('series');

  static const String reasonSeries = 'The series is two letters.';
  static const String reasonNumber = 'The number is three digits.';
  static const String reasonSuffix = 'The suffix is two letters.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_letters2.hasMatch(entry.group('series'))) {
      return const PlateValidation.invalid(reasonSeries);
    }
    if (!isDigitsOfLength(entry.group('number'), 3)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (!_letters2.hasMatch(entry.group('suffix'))) {
      return const PlateValidation.invalid(reasonSuffix);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a 1995-series plate (`ABC 123`).
class ArgentinaLegacyValidator extends GatedPlateValidator {
  const ArgentinaLegacyValidator() : super('series');

  static const String reasonSeries = 'The series is three letters.';
  static const String reasonNumber = 'The number is three digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_letters3.hasMatch(entry.group('series'))) {
      return const PlateValidation.invalid(reasonSeries);
    }
    if (!isDigitsOfLength(entry.group('number'), 3)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a trailer plate (`101 ABC 123`): its own number, then the letters
/// and digits of the primary mover.
class ArgentinaTrailerValidator extends GatedPlateValidator {
  const ArgentinaTrailerValidator() : super('trailer');

  static const String reasonTrailer = 'The trailer number is three digits.';
  static const String reasonSeries = 'The mover\'s series is three letters.';
  static const String reasonNumber = 'The mover\'s number is three digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!isDigitsOfLength(entry.group('trailer'), 3)) {
      return const PlateValidation.invalid(reasonTrailer);
    }
    if (!_letters3.hasMatch(entry.group('series'))) {
      return const PlateValidation.invalid(reasonSeries);
    }
    if (!isDigitsOfLength(entry.group('number'), 3)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a 1995-series foreign-mission plate (`D 123 ABC`): one category
/// letter, three digits and three letters. The prefix is `D` diplomatic, `C`
/// consular, `M` special mission, `I` international organisation or `A`
/// administrative staff. The article prints `D 123 xx A`; the photographs
/// show three trailing letters, and the picture wins.
class ArgentinaMissionValidator extends GatedPlateValidator {
  const ArgentinaMissionValidator() : super('prefix');

  static const String reasonNumber = 'The number is three digits.';
  static const String reasonSuffix = 'The suffix is three letters.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!ArgentinaAlphabets.missionClass.characters.contains(
      entry.group('prefix'),
    )) {
      return const PlateValidation.invalid('The category is D, C, M, I or A.');
    }
    if (!isDigitsOfLength(entry.group('number'), 3)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (!_letters3.hasMatch(entry.group('suffix'))) {
      return const PlateValidation.invalid(reasonSuffix);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a 1985 foreign-mission plate (`CD-1234`). The prefix is `CD`
/// diplomatic, `CC` consular, `ME` special mission, `OI` international
/// organisation or `PA` administrative staff.
class ArgentinaMission1985Validator extends GatedPlateValidator {
  const ArgentinaMission1985Validator() : super('prefix');

  static const String reasonNumber = 'The number is four digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!ArgentinaAlphabets.mission1985Class.characters.contains(
      entry.group('prefix'),
    )) {
      return const PlateValidation.invalid(
        'The category is CD, CC, ME, OI or PA.',
      );
    }
    if (!isDigitsOfLength(entry.group('number'), 4)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}
