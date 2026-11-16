import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'north_macedonia_regions.dart';

/// Judges a North Macedonian plate by its keyed groups. Reports, never bars a
/// keystroke; quiet until the last field has content.
///
/// - `mk.standard`, `mk.legacy`, `mk.two_row`: `region` (one of the 34 area
///   codes), `digits` (four) and `letters` (two): `SK 1234 AB`.
/// - `mk.diplomatic`: `mission` (a listed two-digit code; the refused `35` is
///   reported first), `type` (`CC`, `CD` or `CMD`) and `serial` (two or three
///   digits).
class NorthMacedoniaValidator extends PlateValidator {
  const NorthMacedoniaValidator();

  static const String reasonRegion = 'The area code is not one in use.';
  static const String reasonDigits = 'The number is four digits.';
  static const String reasonLetters = 'The series is two letters.';
  static const String reasonMission = 'The mission code is not listed.';
  static const String reasonType = 'The class is CC, CD or CMD.';
  static const String reasonSerial = 'The serial is two or three digits.';

  static const List<String> _types = <String>['CC', 'CD', 'CMD'];

  static PlateValidation _ok(bool ok, String reason) =>
      ok ? const PlateValidation.valid() : PlateValidation.invalid(reason);

  static bool _letters(String v, int n) =>
      v.length == n &&
      v.split('').every(NorthMacedoniaAlphabets.letters.characters.contains);

  @override
  PlateValidation validate(PlateEntry entry) {
    final bool diplomatic = entry.spec.id == 'mk.diplomatic';
    final String gate = diplomatic ? 'serial' : 'letters';
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    if (entry.group(gate).isEmpty) return const PlateValidation.valid();
    return diplomatic ? _judgeDiplomatic(entry) : _judgeStandard(entry);
  }

  PlateValidation _judgeStandard(PlateEntry entry) {
    if (!NorthMacedoniaRegions.areas.containsKey(entry.group('region'))) {
      return const PlateValidation.invalid(reasonRegion);
    }
    if (!isDigitsOfLength(entry.group('digits'), 4)) {
      return const PlateValidation.invalid(reasonDigits);
    }
    return _ok(_letters(entry.group('letters'), 2), reasonLetters);
  }

  PlateValidation _judgeDiplomatic(PlateEntry entry) {
    if (!isDigitsOfLength(entry.group('mission'), 2)) {
      return const PlateValidation.invalid(reasonMission);
    }
    if (!_types.contains(entry.group('type'))) {
      return const PlateValidation.invalid(reasonType);
    }
    final String serial = entry.group('serial');
    return _ok(
      isDigitsOfLength(serial, 2) || isDigitsOfLength(serial, 3),
      reasonSerial,
    );
  }
}
