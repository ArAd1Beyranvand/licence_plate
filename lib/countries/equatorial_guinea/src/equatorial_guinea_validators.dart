import 'package:license_plate/core/plate_core.dart';

/// Judges `AB-123-C`: province code, three digits, series letter. Reports,
/// never bars a keystroke.
class EquatorialGuineaValidator extends GatedPlateValidator {
  const EquatorialGuineaValidator() : super('series');

  static const Set<String> provinces = <String>{
    'AN',
    'BN',
    'BS',
    'CS',
    'KN',
    'LT',
    'WN',
  };

  static final RegExp _series = RegExp(r'^[A-Z]$');

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!provinces.contains(entry.group('province'))) {
      return PlateValidation.invalid(
        'The province is one of ${provinces.join(', ')}.',
      );
    }
    if (!isDigitsOfLength(entry.group('number'), 3)) {
      return PlateValidation.invalid('The number is 3 digits.');
    }
    if (!_series.hasMatch(entry.group('series'))) {
      return PlateValidation.invalid('The series is 1 letter.');
    }
    return const PlateValidation.valid();
  }
}
