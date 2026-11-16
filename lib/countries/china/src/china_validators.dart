import 'package:license_plate/core/plate_core.dart';

const String _serialChars = '0123456789ABCDEFGHJKLMNPQRSTUVWXYZ';
const String _cityChars = 'ABCDEFGHJKLMNPQRSTUVWXYZ';
const String _suffixes = '学警挂港澳试超';
const String _energyLetters = 'ABCDEFGHJK';

bool _isSerialChars(String s) =>
    s.isNotEmpty && s.split('').every(_serialChars.contains);

int _letters(String s) =>
    s.split('').where((c) => _cityChars.contains(c)).length;

/// Judges a `ChinaPlates.standard` value. Reports, never bars a keystroke.
///
/// Checks: a city letter from A–Z without I and O; a five-character serial
/// of digits and letters (no I, O) with at most two letters, whose last place
/// may instead be a suffix Hanzi (学 警 挂 港 澳 试 超). The province needs no
/// check: its alphabet is a picker.
class ChinaValidator extends GatedPlateValidator {
  const ChinaValidator() : super('serial');

  static const String reasonCity = 'The city letter is A–Z without I and O.';
  static const String reasonSerial =
      'The serial is five digits or letters (no I, O), at most two of them '
      'letters; the last place may be 学 警 挂 港 澳 试 超.';

  @override
  PlateValidation judge(PlateEntry entry) =>
      validateFields(city: entry.group('city'), serial: entry.group('serial'));

  static PlateValidation validateFields({
    required String city,
    required String serial,
  }) {
    if (city.length != 1 || !_cityChars.contains(city)) {
      return const PlateValidation.invalid(reasonCity);
    }
    if (serial.length != 5) return const PlateValidation.invalid(reasonSerial);
    final String last = serial[4];
    final String body = _suffixes.contains(last)
        ? serial.substring(0, 4)
        : serial;
    if (!_isSerialChars(body) || _letters(body) > 2) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a New Energy value on `ChinaPlates.newEnergySmall` or
/// `newEnergyLarge`: six serial characters, the energy letter (A–E G–K; D
/// electric, F other fuels) first on a small plate and last on a large one.
class ChinaNewEnergyValidator extends GatedPlateValidator {
  const ChinaNewEnergyValidator({this.large = false}) : super('serial');

  /// Whether the energy letter ends the serial (a large vehicle).
  final bool large;

  static const String reasonSerial =
      'The serial is six digits or letters (no I, O).';
  static const String reasonEnergy =
      'The energy letter is A–E or F–K (D electric, F other fuels).';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String serial = entry.group('serial');
    if (serial.length != 6 || !_isSerialChars(serial)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    final String energy = large ? serial[5] : serial[0];
    if (!_energyLetters.contains(energy)) {
      return const PlateValidation.invalid(reasonEnergy);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a `ChinaPlates.diplomatic` value: three digits of mission and three
/// of serial. The article lists no code range; Israel's 157 is refused by
/// the spec's restriction before this runs.
class ChinaDiplomaticValidator extends GatedPlateValidator {
  const ChinaDiplomaticValidator() : super('serial');

  static const String reasonDigits =
      'A diplomatic plate is a three-digit mission code and a three-digit '
      'serial.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!isDigitsOfLength(entry.group('mission'), 3) ||
        !isDigitsOfLength(entry.group('serial'), 3)) {
      return const PlateValidation.invalid(reasonDigits);
    }
    return const PlateValidation.valid();
  }
}
