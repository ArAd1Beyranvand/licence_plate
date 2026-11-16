import 'package:license_plate/core/plate_core.dart';

/// Judges a French SIV plate: two letters, three digits (001–999) and two
/// letters, with a département code on the right when the plate has one, or a
/// month and year on a dated plate. The letters leave out I, O and U, and the
/// SS pair. Regular plates never start WW; [temporary] plates always do.
/// Reports, never bars a keystroke.
class FranceValidator extends GatedPlateValidator {
  const FranceValidator({this.temporary = false}) : super('number');

  final bool temporary;

  static const String reasonPrefix =
      'The prefix is two letters (no I, O, U or SS).';
  static const String reasonTemporary = 'A temporary plate starts WW.';
  static const String reasonNumber = 'The number is three digits, 001–999.';
  static const String reasonSuffix =
      'The suffix is two letters (no I, O, U or SS).';
  static const String reasonDepartment =
      'The département is two digits (01–95), 2A or 2B.';
  static const String reasonMonth = 'The month is 01–12.';
  static const String reasonYear = 'The year is two digits.';

  static final RegExp _letters = RegExp(r'^[A-HJ-NP-TV-Z]{2}$');
  static final RegExp _department = RegExp(
    r'^(0[1-9]|1\d|2[1-9]|[3-8]\d|9[0-5]|2A|2B)$',
  );
  static final RegExp _month = RegExp(r'^(0[1-9]|1[0-2])$');

  @override
  PlateValidation judge(PlateEntry entry) {
    final String prefix = entry.group('prefix');
    if (!_letters.hasMatch(prefix) || prefix == 'SS') {
      return const PlateValidation.invalid(reasonPrefix);
    }
    if (temporary != (prefix == 'WW')) {
      return const PlateValidation.invalid(reasonTemporary);
    }
    final String number = entry.group('number');
    if (!isDigitsOfLength(number, 3) || number == '000') {
      return const PlateValidation.invalid(reasonNumber);
    }
    final String suffix = entry.group('suffix');
    if (!_letters.hasMatch(suffix) || suffix == 'SS') {
      return const PlateValidation.invalid(reasonSuffix);
    }
    final String department = entry.group('department');
    if (department.isNotEmpty && !_department.hasMatch(department)) {
      return const PlateValidation.invalid(reasonDepartment);
    }
    final String month = entry.group('month');
    if (month.isNotEmpty && !_month.hasMatch(month)) {
      return const PlateValidation.invalid(reasonMonth);
    }
    final String year = entry.group('year');
    if (year.isNotEmpty && !isDigitsOfLength(year, 2)) {
      return const PlateValidation.invalid(reasonYear);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a diplomatic plate: one to three digits for the embassy, a status
/// (`C` consulate, `CD` embassy, `CMD` ambassador, `K` technical staff) and a
/// series of one to three digits. Reports, never bars a keystroke, except for
/// the spec's restrictions.
class FranceDiplomaticValidator extends GatedPlateValidator {
  const FranceDiplomaticValidator() : super('embassy');

  static const String reasonEmbassy =
      'The embassy code is one to three digits.';
  static const String reasonStatus = 'The status is C, CD, CMD or K.';
  static const String reasonSeries = 'The series is one to three digits.';

  static const List<String> statuses = <String>['C', 'CD', 'CMD', 'K'];

  @override
  PlateValidation judge(PlateEntry entry) {
    final String embassy = entry.group('embassy');
    if (!isDigits(embassy) || embassy.length > 3) {
      return const PlateValidation.invalid(reasonEmbassy);
    }
    if (!statuses.contains(entry.group('status'))) {
      return const PlateValidation.invalid(reasonStatus);
    }
    final String series = entry.group('series');
    if (!isDigits(series) || series.length > 3) {
      return const PlateValidation.invalid(reasonSeries);
    }
    return const PlateValidation.valid();
  }
}
