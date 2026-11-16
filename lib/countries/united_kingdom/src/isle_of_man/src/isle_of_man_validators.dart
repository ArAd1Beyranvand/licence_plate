import 'package:license_plate/core/plate_core.dart';

/// Quiet until something is typed, then every field must reach its minimum and
/// obey the Manx rules: the first letter is never `A`, the middle two are
/// `MN`, the serial is one to three digits and the last letter is never `O`.
/// `I`, `Q`, `S` and `Z` are excluded by the alphabets.
class IsleOfManValidator extends PlateValidator {
  const IsleOfManValidator();

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    if (entry.values.every((String? v) => v == null || v.isEmpty)) {
      return const PlateValidation.valid();
    }
    for (final PlateTextGroup g in entry.spec.effectiveTextGroups) {
      for (final int i in g.indices) {
        final PlateSlot? slot = entry.spec.slotAt(i);
        final String value = i < entry.values.length
            ? (entry.values[i] ?? '')
            : '';
        if (slot != null && !slot.isComplete(value)) {
          return PlateValidation.invalid(
            'The ${g.key ?? 'field'} is incomplete.',
          );
        }
        if (g.key == 'prefix') {
          if (value.startsWith('A')) {
            return const PlateValidation.invalid(
              'The first letter is never A.',
            );
          }
          if (value.substring(1) != 'MN') {
            return const PlateValidation.invalid(
              'The prefix is a letter followed by MN.',
            );
          }
        }
      }
    }
    return const PlateValidation.valid();
  }
}
