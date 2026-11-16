import 'package:license_plate/core/plate_core.dart';

/// Judges a plate by whichever registers its spec has (`AB-12-CD`,
/// `ST-16-KD-G`, `FA-12-34`, `CD-12-345`). Quiet until the last register has
/// something in it. Reports, never bars a keystroke.
class CapeVerdeValidator extends PlateValidator {
  const CapeVerdeValidator();

  static const Set<String> islands = <String>{
    'BR',
    'BV',
    'FG',
    'MA',
    'SA',
    'SL',
    'SN',
    'ST',
    'SV',
  };

  static final Map<String, (RegExp, String)> _shape =
      <String, (RegExp, String)>{
        'series': (RegExp(r'^[A-Z]{2}$'), 'The island code is 2 letters.'),
        'number': (RegExp(r'^[0-9]{2}$'), 'The number is 2 digits.'),
        'letters': (RegExp(r'^[A-Z]{2}$'), 'The closing series is 2 letters.'),
        'suffix': (RegExp(r'^[A-Z]$'), 'The suffix is 1 letter.'),
        'first': (RegExp(r'^[0-9]{2}$'), 'The first number is 2 digits.'),
        'second': (RegExp(r'^[0-9]{2}$'), 'The second number is 2 digits.'),
        'country': (RegExp(r'^[0-9]{2}$'), 'The country code is 2 digits.'),
        'serial': (RegExp(r'^[0-9]{3}$'), 'The serial is 3 digits.'),
      };

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final List<PlateTextGroup> groups = entry.spec.textGroups;
    if (groups.isEmpty || entry.group(groups.last.key!).isEmpty) {
      return const PlateValidation.valid();
    }
    for (final PlateTextGroup g in groups) {
      final (RegExp, String)? rule = _shape[g.key];
      if (rule != null && !rule.$1.hasMatch(entry.group(g.key!))) {
        return PlateValidation.invalid(rule.$2);
      }
    }
    if (entry.spec.id == 'cv.regular' &&
        !islands.contains(entry.group('series'))) {
      return const PlateValidation.invalid('Unknown island code.');
    }
    return const PlateValidation.valid();
  }
}
