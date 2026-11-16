import 'package:license_plate/core/plate_core.dart';

/// Judges a Monaco plate. A car's `serial` is one letter and three digits, four
/// digits, or three digits and one letter; a motorcycle's is two `letters` and
/// two `digits`. Reports, never bars a keystroke.
class MonacoValidator extends PlateValidator {
  const MonacoValidator();

  static const String reasonSerial =
      'The serial is four digits, a letter and three digits, or three digits '
      'and a letter.';
  static const String reasonLetters = 'The motorcycle prefix is two letters.';
  static const String reasonDigits = 'The motorcycle number is two digits.';

  static final RegExp _serial = RegExp(
    r'^(?:[A-Z][0-9]{3}|[0-9]{4}|[0-9]{3}[A-Z])$',
  );
  static final RegExp _letters = RegExp(r'^[A-Z]{2}$');
  static final RegExp _digits = RegExp(r'^[0-9]{2}$');

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final String serial = entry.group('serial');
    if (serial.isNotEmpty) {
      return _serial.hasMatch(serial)
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonSerial);
    }
    final String digits = entry.group('digits');
    if (digits.isEmpty) return const PlateValidation.valid();
    if (!_letters.hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid(reasonLetters);
    }
    return _digits.hasMatch(digits)
        ? const PlateValidation.valid()
        : const PlateValidation.invalid(reasonDigits);
  }
}
