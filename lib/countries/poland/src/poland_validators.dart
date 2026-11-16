import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'poland_missions.dart';

/// Judges a Polish plate, field by field. Reports, never bars a keystroke.
///
/// A car or electric plate is a two- or three-letter county code and a series
/// of five characters (four after a three-letter code), whose letters exclude
/// B, D, I, O and Z. After a two-letter code the series starts with a digit,
/// and after a three-letter one four characters may be neither all digits nor
/// three digits and a letter. A custom plate has a letter and a digit, then
/// three to five characters, a letter first, at most two digits at the end and
/// no letter after a digit; any letter but Q is allowed.
class PolandValidator extends PlateValidator {
  const PolandValidator();

  static const String reasonCode = 'Two or three letters.';
  static const String reasonSeriesLetters =
      'B, D, I, O and Z are not used in a series.';
  static const String reasonCarSeries =
      'Five characters, the first a digit after a two-letter code.';
  static const String reasonThreeLetterSeries =
      'Four characters after a three-letter code may not be digits only, '
      'or three digits and a letter.';
  static const String reasonVoivodeship = 'A letter then a digit.';
  static const String reasonCustom =
      'Three to five characters: a letter first, letters before digits, '
      'at most two digits.';
  static const String reasonProfessional =
      'A letter and two digits, then two digits, P and two digits.';
  static const String reasonTemporary = 'Four digits, or three and a letter.';
  static const String reasonTest = 'Three digits, then the letter B.';
  static const String reasonClassic =
      'Two or three letters and two or three characters, five in all.';
  static const String reasonMotorcycle = 'Two or three letters, then four.';
  static const String reasonReduced = 'A letter, then three characters.';
  static const String reasonDiplomaticLetter = 'W is the only code issued.';
  static const String reasonMission = 'Not a listed mission code.';
  static const String reasonDiplomaticSerial = 'Three digits.';

  static const String _excluded = 'BDIOZ';

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    String g(String key) => entry.group(key);
    final String code = g('code'), serial = g('serial');
    String? bad;
    switch (entry.spec.id) {
      case 'pl.private':
        if (code.isEmpty || serial.isEmpty) break;
        bad = _car(code, serial);
      case 'pl.custom':
        if (code.isEmpty || serial.isEmpty) break;
        bad = _custom(code, serial);
      case 'pl.professional':
        if (code.isEmpty || serial.isEmpty) break;
        if (!(code.length == 3 &&
            _isLetter(code[0]) &&
            isDigits(code.substring(1)) &&
            serial.length == 5 &&
            isDigits(serial.substring(0, 2)) &&
            serial[2] == 'P' &&
            isDigits(serial.substring(3)))) {
          bad = reasonProfessional;
        }
      case 'pl.temporary':
        if (code.isEmpty || serial.isEmpty) break;
        if (!_voivodeshipDigit(code)) {
          bad = reasonVoivodeship;
        } else if (!(serial.length == 4 &&
            isDigits(serial.substring(0, 3)) &&
            (isDigits(serial[3]) || _isLetter(serial[3])))) {
          bad = reasonTemporary;
        }
      case 'pl.test':
        final String n = g('number'), s = g('suffix');
        if (code.isEmpty || n.isEmpty || s.isEmpty) break;
        if (!_voivodeshipDigit(code)) {
          bad = reasonVoivodeship;
        } else if (!isDigitsOfLength(n, 3) || s != 'B') {
          bad = reasonTest;
        }
      case 'pl.classic':
        if (code.isEmpty || serial.isEmpty) break;
        if (!(code.length + serial.length == 5 &&
            code.split('').every(_isLetter))) {
          bad = reasonClassic;
        }
      case 'pl.motorcycle':
        if (code.isEmpty || serial.isEmpty) break;
        if (!(code.length >= 2 &&
            code.split('').every(_isLetter) &&
            serial.length == 4)) {
          bad = reasonMotorcycle;
        }
      case 'pl.reduced':
        if (code.isEmpty || serial.isEmpty) break;
        if (!(_isLetter(code) && serial.length == 3)) bad = reasonReduced;
      case 'pl.diplomatic':
        final String w = g('voivodeship'), m = g('mission'), s = g('serial');
        if (w.isNotEmpty && w != 'W') {
          bad = reasonDiplomaticLetter;
        } else if (m.length == 3 && PolandMissions.all[m] == null) {
          bad = reasonMission;
        } else if (s.isNotEmpty && !isDigits(s)) {
          bad = reasonDiplomaticSerial;
        }
    }
    return bad == null
        ? const PlateValidation.valid()
        : PlateValidation.invalid(bad);
  }

  static bool _isLetter(String c) =>
      PolandAlphabets.letters.characters.contains(c);

  static bool _voivodeshipDigit(String code) =>
      code.length == 2 && _isLetter(code[0]) && isDigits(code[1]);

  static String? _car(String code, String serial) {
    if (!(code.length >= 2 && code.split('').every(_isLetter))) {
      return reasonCode;
    }
    if (serial.split('').any(_excluded.contains)) return reasonSeriesLetters;
    if (code.length == 2) {
      return serial.length == 5 && isDigits(serial[0]) ? null : reasonCarSeries;
    }
    if (serial.length == 5) return null;
    if (serial.length != 4) return reasonCarSeries;
    final bool allDigits = isDigits(serial);
    final bool digitsThenLetter =
        isDigits(serial.substring(0, 3)) && _isLetter(serial[3]);
    return allDigits || digitsThenLetter ? reasonThreeLetterSeries : null;
  }

  static String? _custom(String code, String serial) {
    if (!_voivodeshipDigit(code)) return reasonVoivodeship;
    final bool shape =
        serial.length >= 3 &&
        _isLetter(serial[0]) &&
        !RegExp(r'\d[A-Z]').hasMatch(serial) &&
        RegExp(r'^[A-Z]+\d{0,2}$').hasMatch(serial);
    return shape ? null : reasonCustom;
  }
}
