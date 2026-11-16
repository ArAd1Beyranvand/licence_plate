import 'package:license_plate/core/plate_core.dart';

import 'mexico_plates.dart';

/// Judges a Mexican plate of one [MexicoFormat], field by field. Reports,
/// never bars a keystroke.
///
/// The article gives the shapes (`ABC-12-34`, `AB-12-345`, `ABC-123-A`,
/// `AB-1234-A`, `12-34-ABC`, `123-ABC`) and one letter rule: Mexico City does
/// not issue I, O or Q. The numbering is national, so no letter pair is tied
/// to a state here.
class MexicoValidator extends GatedPlateValidator {
  const MexicoValidator([this.format = MexicoFormat.letters3Digits2Digits2]);

  final MexicoFormat format;

  @override
  String get gateGroup => mexicoFieldKeys[format.fields.length - 1];

  static const String reasonCityLetters = 'Letters I, O and Q are not used.';

  @override
  PlateValidation judge(PlateEntry entry) {
    for (int i = 0; i < format.fields.length; i++) {
      final MexicoField field = format.fields[i];
      final String value = entry.group(mexicoFieldKeys[i]);
      final bool ok = field.letters
          ? RegExp('^[A-Z]{${field.length}}\$').hasMatch(value)
          : isDigitsOfLength(value, field.length);
      if (!ok) {
        return PlateValidation.invalid(
          'Field ${i + 1} is ${field.length} '
          '${field.letters ? 'letter' : 'digit'}'
          '${field.length == 1 ? '' : 's'}.',
        );
      }
      if (format == MexicoFormat.digits3Letters3 &&
          field.letters &&
          RegExp('[IOQ]').hasMatch(value)) {
        return const PlateValidation.invalid(reasonCityLetters);
      }
    }
    return const PlateValidation.valid();
  }
}
