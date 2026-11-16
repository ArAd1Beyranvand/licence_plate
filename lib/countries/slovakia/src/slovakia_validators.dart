import 'package:license_plate/core/plate_core.dart';

final RegExp _twoLetters = RegExp(r'^[A-Z]{2}$');
final RegExp _oneLetter = RegExp(r'^[A-Z]$');
final RegExp _threeDigits = RegExp(r'^\d{3}$');
final RegExp _fiveDigits = RegExp(r'^\d{5}$');

final Map<String, RegExp> _lettersDigitsLetters = <String, RegExp>{
  'a': _twoLetters,
  'b': _threeDigits,
  'c': _twoLetters,
};

final Map<String, RegExp> _twoLine = <String, RegExp>{
  'a': _twoLetters,
  'b': _oneLetter,
  'c': _threeDigits,
};

/// Judges a Slovak plate field by field (`a`, `b`, `c`). Reports, never bars a
/// keystroke.
class SlovakiaValidator extends GatedPlateValidator {
  const SlovakiaValidator() : super('b');

  static const String reason = 'The plate does not match its format.';

  /// Spec id -> one pattern per field key.
  static final Map<String, Map<String, RegExp>> _formats =
      <String, Map<String, RegExp>>{
        'sk.private': _lettersDigitsLetters,
        'sk.privateDash': _lettersDigitsLetters,
        'sk.legacy': _lettersDigitsLetters,
        'sk.temporary': _twoLine,
        'sk.dealer': _twoLine,
        'sk.personalised': <String, RegExp>{
          'a': _twoLetters,
          'b': RegExp(r'^[A-Z0-9]{1,5}$'),
        },
        'sk.imported': <String, RegExp>{'a': _oneLetter, 'b': _fiveDigits},
        'sk.military': <String, RegExp>{
          'a': RegExp(r'^\d{2}$'),
          'b': _fiveDigits,
        },
        'sk.diplomatic': <String, RegExp>{'a': _twoLetters, 'b': _fiveDigits},
        'sk.officials': <String, RegExp>{
          'a': _twoLetters,
          'b': _oneLetter,
          'c': _threeDigits,
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
