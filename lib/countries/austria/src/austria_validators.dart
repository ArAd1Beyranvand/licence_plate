import 'package:license_plate/core/plate_core.dart';

/// Judges an Austrian plate field by field, `a`, `b`, `c`.
///
/// Ordinary plates are one or two district letters, one to five digits and one
/// or two letters; federal plates letters and digits; diplomatic plates `WD`
/// and a mission code (1–2 digits); personalised plates a block of letters
/// then a block of digits, at least three characters together.
/// Reports, never bars a keystroke; judged once the last register has content.
class AustriaValidator extends PlateValidator {
  const AustriaValidator();

  static const String reason = 'The plate does not match its format.';

  static final RegExp _letters12 = RegExp(r'^[A-Z]{1,2}$');
  static final RegExp _digits15 = RegExp(r'^\d{1,5}$');

  static final Map<String, RegExp> _district = <String, RegExp>{
    'a': _letters12,
    'b': _digits15,
    'c': _letters12,
  };

  /// Spec id -> one pattern per field key, in field order.
  static final Map<String, Map<String, RegExp>> _formats =
      <String, Map<String, RegExp>>{
        'at.private': _district,
        'at.electric': _district,
        'at.trailer': _district,
        'at.export': <String, RegExp>{
          'a': _letters12,
          'b': RegExp(r'^\d{1,3}$'),
          'c': _letters12,
        },
        'at.temporary': <String, RegExp>{
          'a': _letters12,
          'b': RegExp(r'^\d{1,2}$'),
          'c': _letters12,
          'd': RegExp(r'^\d{2}$'),
        },
        'at.fire': <String, RegExp>{
          'a': RegExp(r'^FW$'),
          'b': RegExp(r'^\d{1,4}$'),
          'c': _letters12,
        },
        'at.federal': <String, RegExp>{'a': _letters12, 'b': _digits15},
        'at.diplomatic': <String, RegExp>{
          'a': RegExp(r'^[A-Z]{2}$'),
          'mission': RegExp(r'^\d{1,2}$'),
        },
        'at.personalised': <String, RegExp>{
          'a': _letters12,
          'b': RegExp(r'^[A-Z]{1,5}$'),
          'c': RegExp(r'^\d{1,3}$'),
        },
        'at.moped': <String, RegExp>{
          'a': _letters12,
          'b': RegExp(r'^\d{1,3}$'),
          'c': RegExp(r'^[A-Z]{1,3}$'),
        },
      };

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final Map<String, RegExp>? format = _formats[entry.spec.id];
    if (format == null || entry.group(format.keys.last).isEmpty) {
      return const PlateValidation.valid();
    }
    for (final MapEntry<String, RegExp> f in format.entries) {
      if (!f.value.hasMatch(entry.group(f.key))) {
        return const PlateValidation.invalid(reason);
      }
    }
    if (entry.spec.id == 'at.personalised' &&
        entry.group('b').length + entry.group('c').length < 3) {
      return const PlateValidation.invalid(reason);
    }
    return const PlateValidation.valid();
  }
}
