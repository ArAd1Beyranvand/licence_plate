import 'package:license_plate/core/plate_core.dart';

/// Judges a Moldovan plate field by field. Reports, never bars a keystroke.
///
/// Formats are per spec: private and state plates are three letters and
/// three digits, the Ministry of Internal Affairs three and four, the armed
/// forces and president two and four, the protection service two and three,
/// the red plates a letter and four digits (exported: three and a letter)
/// with a month 01–12 and a two-digit year, and the diplomatic plate two
/// letters, three digits and two letters.
class MoldovaValidator extends GatedPlateValidator {
  const MoldovaValidator() : super('digits');

  static const String reason = 'The plate does not match its format.';

  static final RegExp _month = RegExp(r'^(0[1-9]|1[0-2])$');
  static final RegExp _year = RegExp(r'^\d{2}$');

  static Map<String, RegExp> _lettersDigits(int letters, int digits) =>
      <String, RegExp>{
        'letters': RegExp('^[A-Z]{$letters}\$'),
        'digits': RegExp('^\\d{$digits}\$'),
      };

  static final Map<String, Map<String, RegExp>> _formats =
      <String, Map<String, RegExp>>{
        'md.private': _lettersDigits(3, 3),
        'md.state': _lettersDigits(3, 3),
        'md.interior': _lettersDigits(3, 4),
        'md.armedForces': _lettersDigits(2, 4),
        'md.president': _lettersDigits(2, 4),
        'md.protection': _lettersDigits(2, 3),
        'md.foreign': <String, RegExp>{
          ..._lettersDigits(1, 4),
          'month': _month,
          'year': _year,
        },
        'md.exported': <String, RegExp>{
          ..._lettersDigits(1, 3),
          'suffix': RegExp(r'^[A-Z]$'),
          'month': _month,
          'year': _year,
        },
        'md.resident': _lettersDigits(1, 4),
        'md.diplomatic': <String, RegExp>{
          ..._lettersDigits(2, 3),
          'suffix': RegExp(r'^[A-Z]{2}$'),
        },
      };

  @override
  PlateValidation judge(PlateEntry entry) {
    final Map<String, RegExp>? format = _formats[entry.spec.id];
    if (format == null) return const PlateValidation.valid();
    for (final MapEntry<String, RegExp> f in format.entries) {
      if (!f.value.hasMatch(entry.group(f.key))) {
        return const PlateValidation.invalid(reason);
      }
    }
    return const PlateValidation.valid();
  }
}
