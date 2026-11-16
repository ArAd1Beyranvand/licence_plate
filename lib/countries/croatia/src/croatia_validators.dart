import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

/// Judges a Croatian plate by its groups.
///
/// Registration (`region`, `number`, `letters`): a city code, three or four
/// digits and one or two letters (`ZG 543-AA`). Customized (`region`, `word`,
/// `suffix`): a city code, a chosen word of four to five letters, then one or
/// two digits. Police (`first`, `second`): three plus three digits.
/// Diplomatic (`mission`, `class`, `serial`): three digits, a letter, three
/// digits. Reports, never bars a keystroke.
class CroatiaValidator extends PlateValidator {
  const CroatiaValidator();

  static const String reasonRegion = 'The city code is two letters, e.g. ZG.';
  static const String reasonNumber = 'The number is three or four digits.';
  static const String reasonLetters = 'The series is one or two letters.';
  static const String reasonWord = 'The word is four to five letters.';
  static const String reasonSuffix = 'The suffix is one or two digits.';
  static const String reasonPolice = 'Police is three digits, three digits.';
  static const String reasonDiplomatic =
      'Diplomatic is three digits, a letter, three digits.';

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? broken = restrictionVerdict(entry);
    if (broken != null) return broken;
    final List<PlateTextGroup> groups = entry.spec.textGroups;
    if (groups.isEmpty || entry.group(groups.last.key ?? '').isEmpty) {
      return const PlateValidation.valid();
    }
    final String? reason = _reason(entry);
    return reason == null
        ? const PlateValidation.valid()
        : PlateValidation.invalid(reason);
  }

  static String? _reason(PlateEntry e) {
    final String? first = e.spec.textGroups.first.key;
    if (first == 'mission') {
      return isDigitsOfLength(e.group('mission'), 3) &&
              RegExp(r'^[A-Z]$').hasMatch(e.group('class')) &&
              isDigitsOfLength(e.group('serial'), 3)
          ? null
          : reasonDiplomatic;
    }
    if (first == 'first') {
      return isDigitsOfLength(e.group('first'), 3) &&
              isDigitsOfLength(e.group('second'), 3)
          ? null
          : reasonPolice;
    }
    if (!CroatiaAlphabets.regionCodes.contains(e.group('region'))) {
      return reasonRegion;
    }
    if (e.spec.textGroups.any((g) => g.key == 'word')) {
      if (!RegExp(r'^[A-Z]{4,5}$').hasMatch(e.group('word'))) return reasonWord;
      return RegExp(r'^[0-9]{1,2}$').hasMatch(e.group('suffix'))
          ? null
          : reasonSuffix;
    }
    if (!RegExp(r'^[0-9]{3,4}$').hasMatch(e.group('number'))) {
      return reasonNumber;
    }
    return RegExp(r'^[A-Z]{1,2}$').hasMatch(e.group('letters'))
        ? null
        : reasonLetters;
  }
}
