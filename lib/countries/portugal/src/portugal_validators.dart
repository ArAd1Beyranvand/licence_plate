import 'package:license_plate/core/plate_core.dart';

/// Judges a Portuguese plate by the groups its spec carries.
///
/// A registration is three fields of two characters, in one of the series'
/// orders: `AA 00 AA` (2020), `00 AA 00` (2005), `00 00 AA` (1992) and
/// `AA 00 00` (1937), or `A1 00 AA` on the US Forces plates. The ribbon's
/// `year` and `month` are two digits each, the month 01–12. A GNR plate is
/// `GNR`, one letter and four digits; a trailer plate one or two district
/// letters and one to six digits; a diplomatic plate one to three embassy
/// digits, `CD` and three digits. Reports, never bars a keystroke.
class PortugalValidator extends PlateValidator {
  const PortugalValidator();

  static const String reasonShape =
      'A plate is three fields of two characters: letters AA, digits 00.';
  static const String reasonDate = 'The ribbon is a two-digit year and month.';
  static const String reasonGnr = 'A GNR plate is one letter and four digits.';
  static const String reasonTrailer =
      'A trailer plate is one or two district letters and up to six digits.';
  static const String reasonDiplomatic =
      'A diplomatic plate is one to three digits, CD and three digits.';

  static final RegExp _letters = RegExp(r'^[A-Z]{2}$');
  static final RegExp _letter = RegExp(r'^[A-Z]$');
  static final RegExp _mixed = RegExp(r'^[A-Z][0-9]$');

  static bool _pair(String v) => _letters.hasMatch(v) || isDigitsOfLength(v, 2);

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;

    final String embassy = entry.group('embassy');
    if (embassy.isNotEmpty) {
      return embassy.length <= 3 &&
              isDigits(embassy) &&
              entry.group('code') == 'CD' &&
              isDigitsOfLength(entry.group('number'), 3)
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonDiplomatic);
    }
    final String district = entry.group('district');
    if (district.isNotEmpty) {
      final String number = entry.group('number');
      return _letters.hasMatch(district.padRight(2, 'A')) &&
              isDigits(number) &&
              number.length <= 6
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonTrailer);
    }
    final String letter = entry.group('letter');
    if (letter.isNotEmpty) {
      return _letter.hasMatch(letter) &&
              isDigitsOfLength(entry.group('number'), 4)
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonGnr);
    }

    final String first = entry.group('first');
    if (first.isEmpty) return const PlateValidation.valid();
    if (!(_pair(first) || _mixed.hasMatch(first)) ||
        !_pair(entry.group('second')) ||
        !_pair(entry.group('third'))) {
      return const PlateValidation.invalid(reasonShape);
    }
    final String year = entry.group('year'), month = entry.group('month');
    if (year.isNotEmpty || month.isNotEmpty) {
      final int? m = int.tryParse(month);
      if (!isDigitsOfLength(year, 2) ||
          !isDigitsOfLength(month, 2) ||
          m == null ||
          m < 1 ||
          m > 12) {
        return const PlateValidation.invalid(reasonDate);
      }
    }
    return const PlateValidation.valid();
  }
}
