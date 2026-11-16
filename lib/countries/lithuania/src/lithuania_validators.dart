import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'lithuania_missions.dart';

/// Judges a Lithuanian plate, field by field. Reports, never bars a keystroke.
///
/// Letters exclude Q, W and X. Regular plates are three letters and three
/// digits; taxi `T` and dealer `P` plates a letter and five digits; temporary
/// plates four digits and one or two letters; military `LK`, three digits and
/// a letter; agricultural a letter, three or four digits and a letter;
/// diplomatic a listed mission, a status 1–4 and two or three digits.
class LithuaniaValidator extends PlateValidator {
  const LithuaniaValidator();

  static const String reasonLetters = 'Letters exclude Q, W and X.';
  static const String reasonRegular = 'Three letters then three digits.';
  static const String reasonTaxi = 'T then five digits.';
  static const String reasonDealer = 'P then five digits.';
  static const String reasonTemporary = 'Four digits then one or two letters.';
  static const String reasonMilitary = 'LK, three digits, then a letter.';
  static const String reasonAgricultural =
      'A letter, three or four digits, then a letter.';
  static const String reasonMission = 'Not a listed mission code.';
  static const String reasonStatus = 'The status digit is 1 to 4.';
  static const String reasonSerial = 'Two or three digits.';

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final bool Function(String) letters = _letters;
    String g(String key) => entry.group(key);
    String? bad;
    switch (entry.spec.id) {
      case 'lt.private':
        final String l = g('letters'), n = g('number');
        if (l.isEmpty || n.isEmpty) break;
        bad = !letters(l) ? reasonLetters : null;
        if (bad == null && !(l.length == 3 && isDigitsOfLength(n, 3))) {
          bad = reasonRegular;
        }
      case 'lt.taxi':
        bad = _prefixed(g('prefix'), g('number'), 'T', reasonTaxi);
      case 'lt.dealer':
        bad = _prefixed(g('prefix'), g('number'), 'P', reasonDealer);
      case 'lt.temporary':
        final String n = g('number'), l = g('letters');
        if (n.isEmpty || l.isEmpty) break;
        if (!letters(l)) {
          bad = reasonLetters;
        } else if (!(isDigitsOfLength(n, 4) && l.length <= 2)) {
          bad = reasonTemporary;
        }
      case 'lt.military':
        final String c = g('code'), n = g('number'), l = g('letters');
        if (c.isEmpty || n.isEmpty || l.isEmpty) break;
        if (c != 'LK' || !isDigitsOfLength(n, 3) || !letters(l)) {
          bad = reasonMilitary;
        }
      case 'lt.agricultural':
        final String p = g('prefix'), n = g('number'), s = g('suffix');
        if (p.isEmpty || n.isEmpty || s.isEmpty) break;
        if (!letters(p + s)) {
          bad = reasonLetters;
        } else if (!isDigits(n) || n.length < 3) {
          bad = reasonAgricultural;
        }
      case 'lt.diplomatic':
        final String m = g('mission'), s = g('status'), n = g('serial');
        if (m.length == 2 && LithuaniaMissions.all[m] == null) {
          bad = reasonMission;
        } else if (s.isNotEmpty && !'1234'.contains(s)) {
          bad = reasonStatus;
        } else if (n.isNotEmpty && !(isDigits(n) && n.length >= 2)) {
          bad = reasonSerial;
        }
    }
    return bad == null
        ? const PlateValidation.valid()
        : PlateValidation.invalid(bad);
  }

  static bool _letters(String value) =>
      value.split('').every(LithuaniaAlphabets.letters.characters.contains);

  static String? _prefixed(
    String prefix,
    String number,
    String expected,
    String reason,
  ) {
    if (prefix.isEmpty || number.isEmpty) return null;
    return prefix == expected && isDigitsOfLength(number, 5) ? null : reason;
  }
}
