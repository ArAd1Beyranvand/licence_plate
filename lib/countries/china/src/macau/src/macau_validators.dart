import 'package:license_plate/core/plate_core.dart';

/// Every field must use its alphabet and fit its slot's length range.
abstract class _SlotsValidator extends GatedPlateValidator {
  const _SlotsValidator();

  @override
  String get gateGroup => 'digits';

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

/// MA-12-34: a series of letters then two pairs of digits.
class MacauValidator extends _SlotsValidator {
  const MacauValidator();
}

/// CM-x dddd: two to five digits.
class MacauMopedValidator extends _SlotsValidator {
  const MacauMopedValidator();
}

/// The Guangdong supplement: four characters, letters without I and O.
class MacauMainlandValidator extends _SlotsValidator {
  const MacauMainlandValidator();
}
