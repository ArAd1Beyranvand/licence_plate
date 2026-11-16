import 'package:license_plate/core/plate_core.dart';

/// Judges an Eswatini plate field by field: `JSD 884 BM` — a letter and the
/// fixed `SD`, three digits, then a letter and the region's initial. Quiet
/// until the last field has something in it. Reports, never bars a keystroke.
class EswatiniValidator extends PlateValidator {
  const EswatiniValidator();

  /// Region initials: Hhohho, Lubombo, Manzini, Shiselweni.
  static const Set<String> regions = <String>{'H', 'L', 'M', 'S'};

  static final RegExp _series = RegExp(r'^[A-Z]SD$');
  static final RegExp _number = RegExp(r'^[0-9]{3}$');
  static final RegExp _suffix = RegExp(r'^[A-Z]{2}$');

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    if (entry.group('suffix').isEmpty) return const PlateValidation.valid();
    if (!_series.hasMatch(entry.group('series'))) {
      return const PlateValidation.invalid('The series is a letter then SD.');
    }
    if (!_number.hasMatch(entry.group('number'))) {
      return const PlateValidation.invalid('The number is 3 digits.');
    }
    final String suffix = entry.group('suffix');
    if (!_suffix.hasMatch(suffix)) {
      return const PlateValidation.invalid('The suffix is 2 letters.');
    }
    if (!regions.contains(suffix[1])) {
      return const PlateValidation.invalid('Unknown region letter.');
    }
    return const PlateValidation.valid();
  }
}
