import 'package:license_plate/core/plate_core.dart';

/// The checksum letter of a Singaporean registration. Only the last two
/// letters of the prefix count (a single letter is the second, the first is
/// 0); the serial is zero-padded to four digits; the six numbers are weighted
/// 9 4 5 4 3 2, summed, and the remainder mod 19 picks the letter.
abstract final class SingaporeChecksum {
  static const String letters = 'AZYXUTSRPMLKJHGEDCB';
  static const List<int> _weights = <int>[9, 4, 5, 4, 3, 2];

  /// Null when [prefix] or [serial] is not a letter run of 1 to 3 and a digit
  /// run of 1 to 4.
  static String? of(String prefix, String serial) {
    if (prefix.isEmpty || prefix.length > 3 || !_isLetters(prefix)) return null;
    if (!isDigits(serial) || serial.length > 4) return null;
    final String tail = prefix.length > 2
        ? prefix.substring(prefix.length - 2)
        : prefix;
    final List<int> numbers = <int>[
      if (tail.length == 1) 0,
      for (final int u in tail.codeUnits) u - 0x40,
      for (final int u in serial.padLeft(4, '0').codeUnits) u - 0x30,
    ];
    int sum = 0;
    for (int i = 0; i < 6; i++) {
      sum += numbers[i] * _weights[i];
    }
    return letters[sum % 19];
  }

  static bool _isLetters(String s) =>
      s.codeUnits.every((int u) => u >= 0x41 && u <= 0x5A);
}

/// Judges a Singaporean registration: a prefix of one to three letters, a
/// serial of one to four digits without leading zeros, and a checksum letter.
///
/// Reports, never bars a keystroke. The checksum is absent on government and
/// event plates ("SPF 1", "SEP 1"), so an empty one passes. The series rules
/// that skip prefixes (SA, SHE, SKY, vowels in a middle letter, ...) are not
/// judged: the article lists them as policy, not as a format.
class SingaporeValidator extends GatedPlateValidator {
  const SingaporeValidator() : super('serial');

  static const String reasonPrefix = 'The prefix is one to three letters.';
  static const String reasonSerial =
      'The number is one to four digits, without leading zeros.';
  static const String reasonCheck =
      'The checksum letter does not match the number.';

  @override
  PlateValidation judge(PlateEntry entry) => validateFields(
    prefix: entry.group('prefix'),
    serial: entry.group('serial'),
    check: entry.group('check'),
  );

  static PlateValidation validateFields({
    required String prefix,
    required String serial,
    required String check,
  }) {
    if (SingaporeChecksum.of(prefix, '0') == null) {
      return const PlateValidation.invalid(reasonPrefix);
    }
    if (!isDigits(serial) || serial.length > 4 || serial.startsWith('0')) {
      return const PlateValidation.invalid(reasonSerial);
    }
    if (check.isNotEmpty && check != SingaporeChecksum.of(prefix, serial)) {
      return const PlateValidation.invalid(reasonCheck);
    }
    return const PlateValidation.valid();
  }
}
