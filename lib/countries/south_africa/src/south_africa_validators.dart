import 'package:license_plate/core/plate_core.dart';

/// Judges a South African plate field by field: `ABC 123 EC` and
/// `AB 12 CD GP`. Quiet until the last field has something in it. Reports,
/// never bars a keystroke.
class SouthAfricaValidator extends PlateValidator {
  const SouthAfricaValidator();

  /// Province suffixes. `L` is Limpopo; the Western Cape's `WP` and
  /// KwaZulu-Natal's `ZN` are included, and `G`, `M`, `B` mark government,
  /// defence-force and police vehicles.
  static const Set<String> provinces = <String>{
    'EC',
    'FS',
    'GP',
    'L',
    'MP',
    'NC',
    'NW',
    'WP',
    'ZN',
    'G',
    'M',
    'B',
  };

  static final RegExp _letters3 = RegExp(r'^[A-Z]{3}$');
  static final RegExp _letters2 = RegExp(r'^[A-Z]{2}$');
  static final RegExp _digits1to3 = RegExp(r'^[0-9]{1,3}$');
  static final RegExp _digits2 = RegExp(r'^[0-9]{2}$');

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final List<PlateTextGroup> groups = entry.spec.textGroups;
    if (groups.isEmpty || entry.group(groups.last.key!).isEmpty) {
      return const PlateValidation.valid();
    }
    final bool modern = entry.spec.id == 'za.modern';
    for (final PlateTextGroup g in groups) {
      final String value = entry.group(g.key!);
      final (RegExp, String)? rule = switch (g.key) {
        'series' when modern => (_letters2, 'The series is 2 letters.'),
        'series' => (_letters3, 'The series is 3 letters.'),
        'number' when modern => (_digits2, 'The number is 2 digits.'),
        'number' => (_digits1to3, 'The number is 1 to 3 digits.'),
        'letters' => (_letters2, 'The closing letters are 2 letters.'),
        _ => null,
      };
      if (rule != null && !rule.$1.hasMatch(value)) {
        return PlateValidation.invalid(rule.$2);
      }
    }
    if (!provinces.contains(entry.group('province'))) {
      return const PlateValidation.invalid('Unknown province suffix.');
    }
    return const PlateValidation.valid();
  }
}
