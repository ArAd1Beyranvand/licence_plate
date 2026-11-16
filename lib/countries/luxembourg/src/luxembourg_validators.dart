import 'package:license_plate/core/plate_core.dart';

/// One field's rule: letters or digits, `min` to `max` of them.
class _Rule {
  const _Rule(this.key, {required this.digits, required this.min, int? max})
    : max = max ?? min;

  final String key;
  final bool digits;
  final int min, max;
}

/// Judges a Luxembourg plate field by field. Reports, never bars a keystroke.
///
/// Standard plates are two letters and four digits (leading zeros allowed);
/// diplomatic plates `CD` and two pairs of digits; military plates four
/// digits.
class LuxembourgValidator extends PlateValidator {
  const LuxembourgValidator();

  static const String reasonLength = 'A field has the wrong number of symbols.';
  static const String reasonKind = 'A field mixes letters and digits.';

  static const Map<String, List<_Rule>> _rules = <String, List<_Rule>>{
    'lu.standard': <_Rule>[
      _Rule('letters', digits: false, min: 2),
      _Rule('serial', digits: true, min: 4),
    ],
    'lu.diplomatic': <_Rule>[
      _Rule('series', digits: true, min: 2),
      _Rule('serial', digits: true, min: 2),
    ],
    'lu.military': <_Rule>[_Rule('serial', digits: true, min: 4)],
  };

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final List<_Rule> rules = _rules[entry.spec.id] ?? const <_Rule>[];
    if (rules.every((r) => entry.group(r.key).isEmpty)) {
      return const PlateValidation.valid();
    }
    for (final _Rule r in rules) {
      final String v = entry.group(r.key);
      if (v.length < r.min || v.length > r.max) {
        return const PlateValidation.invalid(reasonLength);
      }
      final bool hasDigit = v.codeUnits.any((u) => u >= 0x30 && u <= 0x39);
      if (r.digits ? !isDigits(v) : hasDigit) {
        return const PlateValidation.invalid(reasonKind);
      }
    }
    return const PlateValidation.valid();
  }
}
