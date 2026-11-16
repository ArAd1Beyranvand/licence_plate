import 'package:license_plate/core/plate_core.dart';

/// The third character of a diplomatic plate, by mission. From the article's
/// table; `Q` is unassigned.
abstract final class IcelandMissions {
  static const Map<String, String> names = <String, String>{
    'A': 'United States',
    'B': 'United Kingdom',
    'C': 'Denmark',
    'D': 'Finland',
    'E': 'France',
    'F': 'India',
    'G': 'China',
    'H': 'Norway',
    'I': 'Poland',
    'J': 'Russia',
    'K': 'Sweden',
    'L': 'Czech Republic',
    'M': 'Canada',
    'N': 'Germany',
    'O': 'International Monetary Fund',
    'P': 'Japan',
    'R': 'European Union',
    'S': 'North Atlantic Treaty Organisation',
    'T': 'Spain',
  };
}

final RegExp _letters = RegExp(r'^[A-Z]{2}$');
final RegExp _threeDigits = RegExp(r'^[0-9]{3}$');
final RegExp _letterTwoDigits = RegExp(r'^[A-Z][0-9]{2}$');

/// Judges a two-field plate: two letters and `123` or `C12`; `CD` takes the
/// mission letter and two digits; `RN` takes three digits. Reports, never bars
/// a keystroke.
class IcelandValidator extends GatedPlateValidator {
  const IcelandValidator() : super('serial');

  static const String reasonLetters = 'The prefix is two letters.';
  static const String reasonSerial =
      'The second field is three digits or a letter and two digits.';
  static const String reasonMission =
      'A diplomatic plate is CD, a mission letter and two digits.';
  static const String reasonDealer = 'A dealer plate is RN and three digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String letters = entry.group('letters');
    final String serial = entry.group('serial');
    if (!_letters.hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (letters == 'CD') {
      if (!_letterTwoDigits.hasMatch(serial) ||
          !IcelandMissions.names.containsKey(serial[0])) {
        return const PlateValidation.invalid(reasonMission);
      }
    } else if (letters == 'RN') {
      if (!_threeDigits.hasMatch(serial)) {
        return const PlateValidation.invalid(reasonDealer);
      }
    } else if (!_threeDigits.hasMatch(serial) &&
        !_letterTwoDigits.hasMatch(serial)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a vanity plate: two to six characters that do not follow a standard
/// format (`AB123`, `ABC12`).
class IcelandVanityValidator extends GatedPlateValidator {
  const IcelandVanityValidator() : super('serial');

  static const String reasonLength = 'A vanity plate is two to six characters.';
  static const String reasonStandard =
      'A vanity plate must not follow the standard format.';

  static final RegExp _standard = RegExp(r'^[A-Z]{2}([0-9]{3}|[A-Z][0-9]{2})$');

  @override
  PlateValidation judge(PlateEntry entry) {
    final String value = entry.group('serial');
    if (value.length < 2 || value.length > 6) {
      return const PlateValidation.invalid(reasonLength);
    }
    if (_standard.hasMatch(value)) {
      return const PlateValidation.invalid(reasonStandard);
    }
    return const PlateValidation.valid();
  }
}
