import 'package:license_plate/core/plate_core.dart';

/// Judges a Haitian registration field by field against the lengths the spec's
/// slots give: letters on a plate that has them, then four or five digits.
/// Quiet until the number has something in it. Reports, never bars a keystroke.
class HaitiValidator extends GatedPlateValidator {
  const HaitiValidator() : super('number');

  @override
  PlateValidation judge(PlateEntry entry) {
    for (final PlateTextGroup g in entry.spec.textGroups) {
      final String key = g.key!;
      final PlateSlot slot =
          entry.spec.slots[entry.spec.indicesOfGroup(key).single];
      final String value = entry.group(key);
      final String kind = key == 'series' ? 'letters' : 'digits';
      final bool fits =
          value.length >= slot.minLength &&
          value.length <= slot.length &&
          value.runes.every(
            (int r) => slot.alphabet.accepts(String.fromCharCode(r)),
          );
      if (!fits) {
        return PlateValidation.invalid(
          slot.minLength == slot.length
              ? 'The $key is ${slot.length} $kind.'
              : 'The $key is ${slot.minLength} to ${slot.length} $kind.',
        );
      }
    }
    return const PlateValidation.valid();
  }
}
