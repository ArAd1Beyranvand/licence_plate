import 'package:license_plate/core/plate_core.dart';

/// Judges a Czech plate field by field, `a`, `b`, `c`.
///
/// The current plate is `1A2 3456`: a digit, the regional letter
/// (`A B C E H J K L M P S T U Z`) and a digit or letter, then four characters
/// (`B174` once a series runs out of numbers, `06AC` on electric `EL1 06AC`).
/// The 1992–2001 plate is two or three district letters and two pairs of
/// digits, `ALA 40-11`.
/// Reports, never bars a keystroke.
class CzechRepublicValidator extends GatedPlateValidator {
  const CzechRepublicValidator() : super('b');

  static const String reason = 'The plate does not match its format.';

  static final Map<String, RegExp> _current = <String, RegExp>{
    'a': RegExp(r'^(\d[ABCEHJKLMPSTUZ][A-Z0-9]|EL\d)$'),
    'b': RegExp(r'^[A-Z0-9]{4}$'),
  };

  static final Map<String, RegExp> _digitPairs = <String, RegExp>{
    'b': RegExp(r'^\d{2}$'),
    'c': RegExp(r'^\d{2}$'),
  };

  /// Spec id -> one pattern per field key.
  static final Map<String, Map<String, RegExp>> _formats =
      <String, Map<String, RegExp>>{
        'cz.private': _current,
        'cz.private2001': _current,
        'cz.usSize': _current,
        'cz.motorcycle': <String, RegExp>{
          'a': RegExp(r'^[A-Z0-9]{2}$'),
          'b': RegExp(r'^\d{4}$'),
        },
        'cz.personalised': <String, RegExp>{
          'a': RegExp(r'^[A-Z0-9]{1,3}$'),
          'b': RegExp(r'^[A-Z0-9]{1,5}$'),
        },
        'cz.classic': <String, RegExp>{
          'a': RegExp(r'^[A-Z]{2,3}$'),
          ..._digitPairs,
        },
        'cz.classic70s': <String, RegExp>{
          'a': RegExp(r'^[A-Z]{2}$'),
          ..._digitPairs,
        },
        'cz.military': <String, RegExp>{
          'a': RegExp(r'^\d{3}$'),
          ..._digitPairs,
        },
        'cz.export': <String, RegExp>{
          'a': RegExp(r'^[A-Z0-9]{3}$'),
          'b': RegExp(r'^[A-Z0-9]{3}$'),
        },
        'cz.diplomatic': <String, RegExp>{
          'a': RegExp(r'^\d{3}$'),
          'b': RegExp(r'^[A-Z]{2}$'),
          'c': RegExp(r'^\d{2}$'),
        },
        'cz.veteran': <String, RegExp>{
          'a': RegExp(r'^V$'),
          'b': RegExp(r'^\d{4}$'),
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
