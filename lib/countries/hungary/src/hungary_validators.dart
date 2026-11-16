import 'package:license_plate/core/plate_core.dart';

/// Judges a Hungarian plate field by field, `a`, `b`, `c`.
///
/// The 2022 plate is two letters, two letters and three digits (`AA BP-022`);
/// diplomatic and staff plates two letters and two pairs of digits
/// (`DT 04-56`); agricultural a letter and six digits; export and trial a
/// letter, five digits and a two-digit year (`P-04017 16`); the slow-vehicle
/// plate three letters over three digits.
/// Reports, never bars a keystroke.
class HungaryValidator extends GatedPlateValidator {
  const HungaryValidator() : super('a');

  static const String reason = 'The plate does not match its format.';

  static final RegExp _letter = RegExp(r'^[A-Z]$');
  static final RegExp _two = RegExp(r'^[A-Z]{2}$');
  static final RegExp _three = RegExp(r'^[A-Z]{3}$');

  static final Map<String, Map<String, RegExp>> _formats =
      <String, Map<String, RegExp>>{
        'hu.private': <String, RegExp>{
          'a': _two,
          'b': _two,
          'c': RegExp(r'^\d{3}$'),
        },
        'hu.diplomatic': _pairs,
        'hu.staff': _pairs,
        'hu.agricultural': <String, RegExp>{
          'a': _letter,
          'b': RegExp(r'^\d{6}$'),
        },
        'hu.export': _letterDigitsYear,
        'hu.trial': _letterDigitsYear,
        'hu.slow': <String, RegExp>{'a': _three, 'b': RegExp(r'^\d{3}$')},
      };

  static final Map<String, RegExp> _pairs = <String, RegExp>{
    'a': _two,
    'b': RegExp(r'^\d{2}$'),
    'c': RegExp(r'^\d{2}$'),
  };

  static final Map<String, RegExp> _letterDigitsYear = <String, RegExp>{
    'a': _letter,
    'b': RegExp(r'^\d{5}$'),
    'c': RegExp(r'^\d{2}$'),
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
