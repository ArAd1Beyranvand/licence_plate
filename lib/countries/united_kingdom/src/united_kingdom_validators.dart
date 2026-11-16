import 'package:license_plate/core/plate_core.dart';

/// Quiet until something is typed, then every field must reach its minimum
/// length and obey the DVLA letter rules: `area` never uses `I`, `Q` or `Z`
/// (`Z` is only a random letter), `random` never `I` or `Q`.
class UnitedKingdomValidator extends PlateValidator {
  const UnitedKingdomValidator();

  static const Map<String, String> _forbidden = <String, String>{
    'area': 'IQZ',
    'random': 'IQ',
  };

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    if (entry.values.every((String? v) => v == null || v.isEmpty)) {
      return const PlateValidation.valid();
    }
    for (final PlateTextGroup g in entry.spec.effectiveTextGroups) {
      final String? key = g.key;
      for (final int i in g.indices) {
        final PlateSlot? slot = entry.spec.slotAt(i);
        final String value = i < entry.values.length
            ? (entry.values[i] ?? '')
            : '';
        if (slot != null && !slot.isComplete(value)) {
          return PlateValidation.invalid(
            'The ${key ?? 'field'} is incomplete.',
          );
        }
        final String bad = _forbidden[key] ?? '';
        if (bad.isNotEmpty && value.split('').any(bad.contains)) {
          return PlateValidation.invalid(
            'The $key never uses ${bad.split('').join(', ')}.',
          );
        }
      }
    }
    return const PlateValidation.valid();
  }
}
