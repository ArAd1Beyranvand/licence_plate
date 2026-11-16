import 'package:license_plate/core/plate_core.dart';

/// Judges a Ghanaian plate field by field: region code, one to four digits,
/// two-digit year (`AS 2567-12`, `CR 1-09`). The motorcycle plate leads with
/// `M` and the year (`M-10-AS 1620`). Quiet until the last field has
/// something in it. Reports, never bars a keystroke.
class GhanaValidator extends PlateValidator {
  const GhanaValidator();

  /// Region codes from the article. The services print their own (`GA`, `GP`,
  /// `FS`, `PS`) and `FZB` is the Free Zones Board's.
  static const Set<String> regions = <String>{
    'AC', 'AE', 'AK', 'AP', 'AS', 'AW', //
    'BA', 'BR', 'BW', 'BT', 'CR', //
    'EN', 'ER', 'ES', //
    'GB', 'GC', 'GE', 'GG', 'GH', 'GL', 'GM', 'GN', 'GT', 'GS', 'GW', 'GX',
    'GY', //
    'NR', 'UE', 'UW', 'VA', 'VD', 'VR', 'WR', 'WT', //
    'GA', 'GP', 'FS', 'PS',
  };

  static final RegExp _number = RegExp(r'^[0-9]{1,4}$');
  static final RegExp _year = RegExp(r'^[0-9]{2}$');

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final List<PlateTextGroup> groups = entry.spec.textGroups;
    if (groups.isEmpty || entry.group(groups.last.key!).isEmpty) {
      return const PlateValidation.valid();
    }
    for (final PlateTextGroup g in groups) {
      final String value = entry.group(g.key!);
      final (RegExp, String)? rule = switch (g.key) {
        'number' => (_number, 'The number is 1 to 4 digits.'),
        'year' => (_year, 'The year is 2 digits.'),
        'class' => (RegExp(r'^M$'), 'A motorcycle plate starts with M.'),
        _ => null,
      };
      if (rule != null && !rule.$1.hasMatch(value)) {
        return PlateValidation.invalid(rule.$2);
      }
    }
    if (!regions.contains(entry.group('region'))) {
      return const PlateValidation.invalid('Unknown region code.');
    }
    return const PlateValidation.valid();
  }
}
