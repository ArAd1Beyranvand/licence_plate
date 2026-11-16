import 'package:license_plate/core/plate_core.dart';

/// Quiet until something is typed, then every field must reach its
/// minimum length (the `SHG` prefix whole, the serial one digit).
class SaintHelenaValidator extends PlateValidator {
  const SaintHelenaValidator();

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
      }
    }
    return const PlateValidation.valid();
  }
}
