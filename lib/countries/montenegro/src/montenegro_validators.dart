import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

/// Judges a Montenegrin plate by its keyed groups; which groups exist depends
/// on the design, read off the spec id. Reports, never bars a keystroke.
///
/// - `me.regular`: `region` (a municipal code, two letters), `letters` (two,
///   no `I` or `O`) and `serial` (three digits): `PG AB 123`. The article
///   allows any letter-digit combination on paid custom plates; this judges
///   the standard series.
/// - `me.diplomatic`: `code` (two or three digits), `letter` (`A`, `M`, `P`,
///   `E` or `C`) and `serial` (three digits): `53 A 002`.
/// - `me.temporary`: `region`, `year` (two digits) and `serial` (three).
/// - `me.agricultural`: `region`, `letters` (two) and `serial` (two digits).
/// - `me.moped`: `region` and `serial` (four letters or digits).
class MontenegroValidator extends GatedPlateValidator {
  const MontenegroValidator() : super('serial');

  static const String reasonRegion =
      'The municipal code is two letters, e.g. PG.';
  static const String reasonDigits = 'Check the number of digits.';
  static const String reasonLetters = 'Check the series letters.';

  static const List<String> municipalities = <String>[
    'AN', 'BA', 'BD', 'BP', 'BR', 'CT', 'DG', 'GS', 'HN', 'KL', 'KO', 'MK', //
    'NK', 'PG', 'PL', 'PT', 'PŽ', 'PV', 'RO', 'ŠN', 'TV', 'TZ', 'UL', 'ZT',
    'ŽB',
  ];

  static bool _in(PlateAlphabet a, String v, int n) =>
      v.length == n && v.split('').every(a.characters.contains);

  PlateValidation _ok(bool ok, String reason) =>
      ok ? const PlateValidation.valid() : PlateValidation.invalid(reason);

  @override
  PlateValidation judge(PlateEntry entry) {
    final String id = entry.spec.id;
    if (id == 'me.diplomatic') {
      final String code = entry.group('code');
      return _ok(
        (isDigitsOfLength(code, 2) || isDigitsOfLength(code, 3)) &&
            _in(
              MontenegroAlphabets.diplomaticLetters,
              entry.group('letter'),
              1,
            ) &&
            isDigitsOfLength(entry.group('serial'), 3),
        reasonDigits,
      );
    }
    if (!municipalities.contains(entry.group('region'))) {
      return const PlateValidation.invalid(reasonRegion);
    }
    final String serial = entry.group('serial');
    switch (id) {
      case 'me.regular':
        return _ok(
          _in(MontenegroAlphabets.letters, entry.group('letters'), 2) &&
              isDigitsOfLength(serial, 3),
          reasonLetters,
        );
      case 'me.temporary':
        return _ok(
          isDigitsOfLength(entry.group('year'), 2) &&
              isDigitsOfLength(serial, 3),
          reasonDigits,
        );
      case 'me.agricultural':
        return _ok(
          _in(MontenegroAlphabets.letters, entry.group('letters'), 2) &&
              isDigitsOfLength(serial, 2),
          reasonLetters,
        );
      default:
        return _ok(_in(MontenegroAlphabets.mixed, serial, 4), reasonDigits);
    }
  }
}
