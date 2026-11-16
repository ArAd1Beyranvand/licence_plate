import 'package:license_plate/core/plate_core.dart';

/// Six digits, the printed `NC` being fixed.
class NewCaledoniaValidator extends GatedPlateValidator {
  const NewCaledoniaValidator() : super('number');

  static const String reasonDigits = 'The number must be six digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String v = entry.group('number');
    if (!entry.spec.slots.first.accepts(v) || v.length != 6) {
      return const PlateValidation.invalid(reasonDigits);
    }
    return const PlateValidation.valid();
  }
}
