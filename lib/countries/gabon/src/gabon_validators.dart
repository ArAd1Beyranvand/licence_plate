import 'package:license_plate/core/plate_core.dart';

/// Judges `AB-123-CD`: two letters, three digits, two letters. Reports, never
/// bars a keystroke.
class GabonValidator extends RuledPlateValidator {
  const GabonValidator() : super('number');

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('series', r'[A-Z]{2}', 'The first group is 2 letters.'),
    PlateCheck('number', r'[0-9]{3}', 'The number is 3 digits.'),
    PlateCheck('suffix', r'[A-Z]{2}', 'The last group is 2 letters.'),
  ];
}
