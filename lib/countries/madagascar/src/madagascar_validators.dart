import 'package:license_plate/core/plate_core.dart';

/// Advisory validator over whichever of `number`, `series` (first letter the
/// province) and `country` (diplomatic code) the spec has. Empty groups are
/// not judged.
class MadagascarValidator extends PlateValidator {
  const MadagascarValidator();

  static const Set<String> provinces = <String>{'A', 'D', 'F', 'M', 'T', 'U'};
  static const Set<String> diplomaticSeries = <String>{
    'CD',
    'CMD',
    'CMC',
    'PE',
  };

  static const String reasonNumber = 'The number is one to five digits.';
  static const String reasonSeries = 'The series is two or three letters.';
  static const String reasonProvince =
      'The first letter is the province: A, D, F, M, T or U.';
  static const String reasonCountry = 'The country code is three digits.';
  static const String reasonDiplomatic = 'The series is CD, CMD, CMC or PE.';

  static final RegExp _number = RegExp(r'^[0-9]{1,5}$');
  static final RegExp _series = RegExp(r'^[A-Z]{1,3}$');
  static final RegExp _country = RegExp(r'^[0-9]{3}$');

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? broken = restrictionVerdict(entry);
    if (broken != null) return broken;
    final String number = entry.group('number'), series = entry.group('series');
    final String country = entry.group('country');
    if (number.isNotEmpty && !_number.hasMatch(number)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (country.isNotEmpty) {
      if (!_country.hasMatch(country)) {
        return const PlateValidation.invalid(reasonCountry);
      }
      if (series.isNotEmpty && !diplomaticSeries.contains(series)) {
        return const PlateValidation.invalid(reasonDiplomatic);
      }
    } else if (series.isNotEmpty) {
      if (!_series.hasMatch(series)) {
        return const PlateValidation.invalid(reasonSeries);
      }
      // The province letter leads a standard series; the dealer plate prints
      // only the province, and the temporary series leads with `WW`.
      final String province = series.startsWith('WW')
          ? series.substring(series.length - 1)
          : series[0];
      if (series.length > 1 && !provinces.contains(province)) {
        return const PlateValidation.invalid(reasonProvince);
      }
    }
    return const PlateValidation.valid();
  }
}
