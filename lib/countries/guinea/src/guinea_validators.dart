import 'package:license_plate/core/plate_core.dart';

/// Judges a Guinean plate field by field, for whichever groups the spec has:
///
/// - current: `series` 2 letters, `number` 4 digits, `region` 2 digits
///   (`01`–`08`), and on motorcycles a one-letter `suffix`;
/// - 1994: `prefix` 2 letters (`RC` is Conakry), `number` 4 digits, `series`
///   1 letter (taxi, truck) or 2 letters (private).
///
/// The article prints the current number as `AB-123` but the plate shows
/// `0123`; the picture wins. Reports, never bars a keystroke.
class GuineaValidator extends GatedPlateValidator {
  const GuineaValidator() : super('number');

  @override
  PlateValidation judge(PlateEntry entry) {
    final Set<String> keys = <String>{
      for (final PlateTextGroup g in entry.spec.textGroups)
        if (g.key != null) g.key!,
    };
    final bool legacy = keys.contains('prefix');
    final Map<String, (RegExp, String)> rules = <String, (RegExp, String)>{
      'series': (
        RegExp(legacy ? r'^[A-Z]{1,2}$' : r'^[A-Z]{2}$'),
        legacy ? 'The series is 1 or 2 letters.' : 'The series is 2 letters.',
      ),
      'number': (RegExp(r'^\d{4}$'), 'The number is 4 digits.'),
      'prefix': (
        RegExp(r'^[A-Z]{2}$'),
        'The region code is 2 letters (RC is Conakry).',
      ),
      'region': (RegExp(r'^0[1-8]$'), 'The region code is 01 to 08.'),
      'suffix': (RegExp(r'^[A-Z]$'), 'The suffix is 1 letter.'),
    };
    for (final MapEntry<String, (RegExp, String)> rule in rules.entries) {
      if (!keys.contains(rule.key)) continue;
      if (!rule.value.$1.hasMatch(entry.group(rule.key))) {
        return PlateValidation.invalid(rule.value.$2);
      }
    }
    return const PlateValidation.valid();
  }
}
