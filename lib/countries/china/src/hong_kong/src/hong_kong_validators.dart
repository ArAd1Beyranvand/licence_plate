import 'package:license_plate/core/plate_core.dart';

/// Every field must use its alphabet and stay within its slot's length range.
class HongKongValidator extends GatedPlateValidator {
  const HongKongValidator() : super('digits');

  static const String reasonField =
      'A field has the wrong length or characters.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final PlateSpec spec = entry.spec;
    for (var i = 0; i < spec.slots.length; i++) {
      final PlateSlot slot = spec.slots[i];
      final String v = entry.group(spec.textGroups[i].key!);
      if (!slot.accepts(v) ||
          v.length < slot.minLength ||
          v.length > slot.length) {
        return const PlateValidation.invalid(reasonField);
      }
    }
    return const PlateValidation.valid();
  }
}
