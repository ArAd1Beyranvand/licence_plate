import 'package:license_plate/core/plate_core.dart';

/// Judges a South Ossetian registration: each field the right length and
/// alphabet. Reports, never bars a keystroke.
class SouthOssetiaValidator extends GatedPlateValidator {
  const SouthOssetiaValidator() : super('series');

  static const String reasonField = 'A field has the wrong length or letters.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final PlateSpec spec = entry.spec;
    for (var i = 0; i < spec.slots.length; i++) {
      final PlateSlot slot = spec.slots[i];
      final String value = entry.group(spec.textGroups[i].key!);
      if (!slot.accepts(value) ||
          value.length < slot.minLength ||
          value.length > slot.length) {
        return const PlateValidation.invalid(reasonField);
      }
    }
    return const PlateValidation.valid();
  }
}
