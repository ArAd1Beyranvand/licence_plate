import 'package:license_plate/core/plate_core.dart';

import 'ukraine_missions.dart';

/// Judges a Ukrainian plate field by field: every field must be filled once
/// the last one (`series`) is started. A diplomatic `mission` is checked
/// against [UkraineMissions] and `012` is refused on this validator's own
/// account as well as through the spec's restriction. Advisory.
class UkraineValidator extends GatedPlateValidator {
  const UkraineValidator() : super('series');

  @override
  PlateValidation validate(PlateEntry entry) {
    if (UkraineMissions.isRefused(entry.group('mission'))) {
      return const PlateValidation.invalid(UkraineMissions.notFound);
    }
    return super.validate(entry);
  }

  @override
  PlateValidation judge(PlateEntry entry) {
    for (final PlateTextGroup g in entry.spec.textGroups) {
      final String? key = g.key;
      if (key == null) continue;
      if (entry.group(key).isEmpty) {
        return PlateValidation.invalid('The $key is incomplete.');
      }
    }
    final String mission = entry.group('mission');
    if (mission.isNotEmpty && UkraineMissions.name(mission) == null) {
      return const PlateValidation.invalid(UkraineMissions.notFound);
    }
    return const PlateValidation.valid();
  }
}
