import 'package:license_plate/core/plate_core.dart';

import 'abkhazia_plates.dart';

/// Judges a registration on any [AbkhaziaPlates] spec. Reports, never bars a
/// keystroke. The diplomatic number is one digit after `CD`, three after `D`
/// or `T` (assumed from Russia).
class AbkhaziaValidator extends GatedPlateValidator {
  const AbkhaziaValidator() : super('series');

  static const String reasonField = 'A field has the wrong length or letters.';
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
    if (spec.id == AbkhaziaPlates.diplomatic.id) {
      final int want = entry.group('status') == 'CD' ? 1 : 3;
      if (entry.group('number').length != want) {
        return const PlateValidation.invalid(reasonNumber);
      }
    }
    return const PlateValidation.valid();
  }
}
