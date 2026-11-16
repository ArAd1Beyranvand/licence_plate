import 'package:license_plate/core/plate_core.dart';

import 'australia_formats.dart';

/// Judges an Australian plate against its design's [AustraliaFormats]. Reports,
/// never bars a keystroke.
///
/// Quiet until the first field has a character. Each field must then be whole
/// and match its shape (the NSW suffix skips `I` and `O`; WA and VIC skip a
/// leading 0). The jurisdictions have different formats, so the spec's id
/// picks them; an unknown spec is valid.
class AustraliaValidator extends GatedPlateValidator {
  const AustraliaValidator() : super('f0');

  static const String reasonField =
      'A field does not fit this plate\'s format.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final List<AustraliaField>? fields =
        AustraliaFormats.bySpecId[entry.spec.id];
    if (fields == null) return const PlateValidation.valid();
    for (var i = 0; i < fields.length; i++) {
      if (!fields[i].accepts(entry.group(australiaFieldKey(i)))) {
        return const PlateValidation.invalid(reasonField);
      }
    }
    return const PlateValidation.valid();
  }
}
