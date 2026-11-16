import 'package:license_plate/core/plate_core.dart';

/// Quiet until something is typed, then the digit run must reach its minimum
/// (Guernsey one to five digits, Alderney one to four after the printed `AY`).
class GuernseyValidator extends PlateValidator {
  const GuernseyValidator();

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final String serial =
        (entry.values.isEmpty ? null : entry.values.first) ?? '';
    if (serial.isEmpty) return const PlateValidation.valid();
    final PlateSlot? slot = entry.spec.slotAt(0);
    if (slot != null && !slot.isComplete(serial)) {
      return const PlateValidation.invalid('The serial is incomplete.');
    }
    return const PlateValidation.valid();
  }
}
