import 'package:license_plate/core/plate_core.dart';

/// Judges `BJL 0123 A` field by field: `region`, `number` (4 digits) and
/// `suffix` (1 letter). Reports, never bars a keystroke.
class GambiaValidator extends GatedPlateValidator {
  const GambiaValidator() : super('number');

  /// Codes from 2019 (`BJL`, `WCR`, `NBR`, `LRR`, `CRR`, `URR`, `KM`) and the
  /// 1994–2019 ones still in the street (`WD`, `NBD`, `LRD`, `CRD`, `URD`).
  static const Set<String> regions = <String>{
    'BJL', 'KM', //
    'WCR', 'NBR', 'LRR', 'CRR', 'URR',
    'WD', 'NBD', 'LRD', 'CRD', 'URD',
  };

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!regions.contains(entry.group('region'))) {
      return PlateValidation.invalid('The region code is not a known one.');
    }
    if (!isDigitsOfLength(entry.group('number'), 4)) {
      return PlateValidation.invalid('The number is 4 digits.');
    }
    if (!RegExp(r'^[A-Z]$').hasMatch(entry.group('suffix'))) {
      return PlateValidation.invalid('The suffix is 1 letter.');
    }
    return const PlateValidation.valid();
  }
}
