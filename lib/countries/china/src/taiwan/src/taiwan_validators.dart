import 'package:license_plate/core/plate_core.dart';

/// 2014 series: three letters (no I, O) then four digits.
class TaiwanValidator extends GatedPlateValidator {
  const TaiwanValidator() : super('digits');

  static const String reasonField = 'Three letters and four digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final PlateSpec spec = entry.spec;
    for (var i = 0; i < spec.slots.length; i++) {
      final PlateSlot slot = spec.slots[i];
      final String v = entry.group(spec.textGroups[i].key!);
      if (!slot.accepts(v) || v.length != slot.length)
        return const PlateValidation.invalid(reasonField);
    }
    return const PlateValidation.valid();
  }
}

/// 1992 series: two letters then four digits; the slot lengths already say so.
class TaiwanLegacyValidator extends TaiwanValidator {
  const TaiwanLegacyValidator();
}

/// Embassy and foreign-affairs plates: the glyph then [minDigits]–[maxDigits] digits.
class TaiwanProtocolValidator extends GatedPlateValidator {
  const TaiwanProtocolValidator({this.minDigits = 2, this.maxDigits = 3})
    : super('digits');

  final int minDigits, maxDigits;

  static const String reasonDigits = 'The number has the wrong length.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String v = entry.group('digits');
    if (!entry.spec.slots.first.accepts(v) ||
        v.length < minDigits ||
        v.length > maxDigits) {
      return const PlateValidation.invalid(reasonDigits);
    }
    return const PlateValidation.valid();
  }
}
