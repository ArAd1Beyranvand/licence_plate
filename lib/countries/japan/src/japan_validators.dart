import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

/// Judges a Japanese plate by its fields. Reports, never bars a keystroke.
///
/// A car plate is an office, a class code of two or three characters (digits,
/// the third possibly a letter), a hiragana and a serial of four places whose
/// leading zeros are dots (`・・12`). A two-wheeler plate has no class code.
/// The export plate swaps the office and hiragana for Roman letters — two or
/// three for the office, one or two for the kana — and keeps four digits; the
/// diplomatic plate is five digits.
class JapanValidator extends GatedPlateValidator {
  const JapanValidator() : super('serial');

  static const String reasonCar =
      'A plate is an office, a class code, a hiragana and a four-place serial.';
  static const String reasonClass =
      'A class code is two digits, then a digit or a letter.';
  static const String reasonSerial =
      'A serial is four places; leading zeros are printed as dots.';
  static const String reasonExport =
      'An export plate is two or three letters, one or two letters and four '
      'digits.';
  static const String reasonDiplomatic = 'A diplomatic plate is five digits.';

  static final RegExp _class = RegExp(r'^[0-9]{2}[0-9A-Z]?$');
  static final RegExp _officeLatin = RegExp(r'^[A-Z]{2,3}$');
  static final RegExp _kanaLatin = RegExp(r'^[A-Z]{1,2}$');
  static final RegExp _serial = RegExp(r'^(・・|・[0-9]|[0-9]{2})[0-9]{2}$');

  @override
  PlateValidation judge(PlateEntry entry) {
    final String serial = entry.group('serial'), office = entry.group('office');
    final String kana = entry.group('kana');
    if (office.isEmpty) {
      return isDigitsOfLength(serial, 5)
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonDiplomatic);
    }
    final bool latin = JapanAlphabets.letters.accepts(office[0]);
    if (latin) {
      return _officeLatin.hasMatch(office) &&
              _kanaLatin.hasMatch(kana) &&
              isDigitsOfLength(serial, 4)
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonExport);
    }
    if (kana.isEmpty) return const PlateValidation.invalid(reasonCar);
    if (entry.spec.indicesOfGroup('class').isNotEmpty &&
        !_class.hasMatch(entry.group('class'))) {
      return const PlateValidation.invalid(reasonClass);
    }
    return _serial.hasMatch(serial)
        ? const PlateValidation.valid()
        : const PlateValidation.invalid(reasonSerial);
  }
}
