import 'package:license_plate/core/plate_core.dart';

import 'transnistria_regions.dart';

/// Judges a Transnistrian registration: each field the right length and
/// alphabet, and the region letter one of [TransnistriaRegions]. Reports,
/// never bars a keystroke.
class TransnistriaValidator extends GatedPlateValidator {
  const TransnistriaValidator() : super('serial');

  static const String reasonField = 'A field has the wrong length or letters.';
  static const String reasonRegion = 'The region letter is not in use.';

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
    final String region = entry.group('region');
    if (region.isNotEmpty && !TransnistriaRegions.codes.contains(region)) {
      return const PlateValidation.invalid(reasonRegion);
    }
    return const PlateValidation.valid();
  }
}
