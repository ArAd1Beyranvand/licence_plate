import 'package:license_plate/core/plate_core.dart';

/// Judges an Ivory Coast plate field by field: `1234 AB 56` on a private
/// plate, `123 CD 45` on the others, `12345` on a military one. Quiet until
/// the last field has something in it. Reports, never bars a keystroke.
class IvoryCoastValidator extends PlateValidator {
  const IvoryCoastValidator();

  static final RegExp _letters2 = RegExp(r'^[A-Z]{2}$');
  static final RegExp _digits2 = RegExp(r'^[0-9]{2}$');
  static final RegExp _digits3 = RegExp(r'^[0-9]{3}$');
  static final RegExp _digits4 = RegExp(r'^[0-9]{4}$');
  static final RegExp _digits5 = RegExp(r'^[0-9]{5}$');

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final List<PlateTextGroup> groups = entry.spec.textGroups;
    if (groups.isEmpty || entry.group(groups.last.key!).isEmpty) {
      return const PlateValidation.valid();
    }
    final String id = entry.spec.id;
    for (final PlateTextGroup g in groups) {
      final String value = entry.group(g.key!);
      final (RegExp, String)? rule = switch (g.key) {
        'number' when id == 'ci.private' => (
          _digits4,
          'The number is 4 digits.',
        ),
        'number' when id == 'ci.military' => (
          _digits5,
          'The number is 5 digits.',
        ),
        'number' => (_digits3, 'The number is 3 digits.'),
        'series' => (_letters2, 'The series is 2 letters.'),
        'region' => (_digits2, 'The region code is 2 digits.'),
        _ => null,
      };
      if (rule != null && !rule.$1.hasMatch(value)) {
        return PlateValidation.invalid(rule.$2);
      }
    }
    return const PlateValidation.valid();
  }
}
