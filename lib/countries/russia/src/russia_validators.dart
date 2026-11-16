import 'package:license_plate/core/plate_core.dart';

import 'russia_missions.dart';
import 'russia_plates.dart';
import 'russia_regions.dart';

/// Judges a registration on any [RussiaPlates] spec. Reports, never bars a
/// keystroke. The region is a formation code on the military plate.
class RussiaValidator extends GatedPlateValidator {
  const RussiaValidator() : super('region');

  static const String reasonField = 'A field has the wrong length or letters.';
  static const String reasonRegion = 'The region code is not in use.';
  static const String reasonMission = 'The mission code is not in use.';
  static const String reasonNumber =
      'The diplomatic number is one digit after CD, three after D or T.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final PlateSpec spec = entry.spec;
    for (var i = 0; i < spec.slots.length; i++) {
      final PlateSlot slot = spec.slots[i];
      final String value = entry.group(spec.textGroups[i].key!);
      final bool whole = slot.alphabet.input == AlphabetInput.chosen;
      if (!slot.accepts(value) ||
          !whole &&
              (value.length < slot.minLength || value.length > slot.length)) {
        return const PlateValidation.invalid(reasonField);
      }
    }
    final String region = entry.group('region');
    if (spec.id == RussiaPlates.diplomatic.id) {
      if (!RussiaMissions.all.containsKey(entry.group('code'))) {
        return const PlateValidation.invalid(reasonMission);
      }
      final int want = entry.group('status') == 'CD' ? 1 : 3;
      if (entry.group('number').length != want) {
        return const PlateValidation.invalid(reasonNumber);
      }
    }
    final bool known = spec.id == RussiaPlates.military.id
        ? RussiaRegions.militaryCodes.contains(region)
        : RussiaRegions.codes.contains(region);
    if (!known) {
      return const PlateValidation.invalid(reasonRegion);
    }
    return const PlateValidation.valid();
  }
}
