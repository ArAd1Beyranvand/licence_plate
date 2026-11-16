import 'package:license_plate/core/plate_core.dart';

final RegExp _letters2 = RegExp(r'^[A-Z]{2}$');
final RegExp _letter = RegExp(r'^[A-Z]$');

/// Judges a private, repetitive or motorcycle plate (`AB 123 CD`; the
/// motorcycle has no suffix). Reports, never bars a keystroke.
class AlbaniaPrivateValidator extends GatedPlateValidator {
  const AlbaniaPrivateValidator() : super('series');

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
    final String suffix = entry.group('suffix');
    if (suffix.isNotEmpty && !_letters2.hasMatch(suffix)) {
      return const PlateValidation.invalid(reasonSuffix);
    }
    return const PlateValidation.valid();
  }
}

/// Judges an agricultural, technological or trailer plate: `AB MB 78`,
/// `AB MT 78`, `AB RB 78`, `AB RT 78` (two digits) or `AB R 456` (three).
class AlbaniaAgriculturalValidator extends GatedPlateValidator {
  const AlbaniaAgriculturalValidator() : super('series');

  static const List<String> classes = <String>['MB', 'MT', 'RB', 'RT', 'R'];

  static const String reasonSeries = 'The series is two letters.';
  static const String reasonClass = 'The class is MB, MT, RB, RT or R.';
  static const String reasonNumber =
      'The number is three digits after R, two after the others.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_letters2.hasMatch(entry.group('series'))) {
      return const PlateValidation.invalid(reasonSeries);
    }
    final String kind = entry.group('class');
    if (!classes.contains(kind)) {
      return const PlateValidation.invalid(reasonClass);
    }
    if (!isDigitsOfLength(entry.group('number'), kind == 'R' ? 3 : 2)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a diplomatic (`CD`) or service-diplomatic (`TR`) plate
/// (`CD 12 03A`): the mission code, a two-digit number and a rank letter.
class AlbaniaDiplomaticValidator extends GatedPlateValidator {
  const AlbaniaDiplomaticValidator() : super('prefix');

  static const String reasonPrefix = 'The prefix is CD or TR.';
  static const String reasonCode = 'The mission code is two digits.';
  static const String reasonNumber = 'The number is two digits.';
  static const String reasonSuffix = 'The rank is one letter.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String prefix = entry.group('prefix');
    if (prefix != 'CD' && prefix != 'TR') {
      return const PlateValidation.invalid(reasonPrefix);
    }
    if (!isDigitsOfLength(entry.group('code'), 2)) {
      return const PlateValidation.invalid(reasonCode);
    }
    if (!isDigitsOfLength(entry.group('number'), 2)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (!_letter.hasMatch(entry.group('suffix'))) {
      return const PlateValidation.invalid(reasonSuffix);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a military plate (`MM 123PU`): the ministry prefix, three digits and
/// a branch code.
class AlbaniaMilitaryValidator extends GatedPlateValidator {
  const AlbaniaMilitaryValidator() : super('prefix');

  static const List<String> branches = <String>[
    'FA',
    'FD',
    'FT',
    'KM',
    'PU',
    'SP',
  ];

  static const String reasonPrefix = 'The prefix is MM.';
  static const String reasonNumber = 'The number is three digits.';
  static const String reasonSuffix = 'The branch is FA, FD, FT, KM, PU or SP.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (entry.group('prefix') != 'MM') {
      return const PlateValidation.invalid(reasonPrefix);
    }
    if (!isDigitsOfLength(entry.group('number'), 3)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (!branches.contains(entry.group('suffix'))) {
      return const PlateValidation.invalid(reasonSuffix);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a police plate (`MB 123 AB`): the ministry prefix, three digits and
/// two letters.
class AlbaniaPoliceValidator extends GatedPlateValidator {
  const AlbaniaPoliceValidator() : super('prefix');

  static const String reasonPrefix = 'The prefix is MB.';
  static const String reasonNumber = 'The number is three digits.';
  static const String reasonSuffix = 'The suffix is two letters.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (entry.group('prefix') != 'MB') {
      return const PlateValidation.invalid(reasonPrefix);
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

/// Judges a taxi plate (`AB 123 T`).
class AlbaniaTaxiValidator extends GatedPlateValidator {
  const AlbaniaTaxiValidator() : super('series');

  static const String reasonSeries = 'The series is two letters.';
  static const String reasonNumber = 'The number is three digits.';
  static const String reasonSuffix = 'A taxi plate ends in T.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_letters2.hasMatch(entry.group('series'))) {
      return const PlateValidation.invalid(reasonSeries);
    }
    if (!isDigitsOfLength(entry.group('number'), 3)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (entry.group('suffix') != 'T') {
      return const PlateValidation.invalid(reasonSuffix);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a temporary (`AB 0 PRK`) or test (`AB 0 PROV`) plate.
class AlbaniaProvisionalValidator extends GatedPlateValidator {
  const AlbaniaProvisionalValidator() : super('series');

  static const String reasonSeries = 'The series is two letters.';
  static const String reasonNumber = 'The number is one digit.';
  static const String reasonWord =
      'The word is PRK (temporary) or PROV (test).';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_letters2.hasMatch(entry.group('series'))) {
      return const PlateValidation.invalid(reasonSeries);
    }
    if (!isDigitsOfLength(entry.group('number'), 1)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    final String word = entry.group('word');
    if (word != 'PRK' && word != 'PROV') {
      return const PlateValidation.invalid(reasonWord);
    }
    return const PlateValidation.valid();
  }
}
