import 'package:license_plate/core/plate_core.dart';

/// One digit field a [MoroccoValidator] checks: its text-group key and how
/// many digits the plate takes.
class MoroccoField {
  const MoroccoField(this.group, this.min, this.max);

  final String group;
  final int min, max;
}

/// Judges a Moroccan plate from its fields. Reports, never bars a keystroke.
///
/// Checks that every digit field is digits within its length, that a
/// registration plate carries a series letter, and that a number is not all
/// zeros. Does not check which regions or series have been issued.
class MoroccoValidator extends GatedPlateValidator {
  const MoroccoValidator({required this.fields, this.requiresSeries = false})
    : super('serial');

  final List<MoroccoField> fields;
  final bool requiresSeries;

  /// `NNNNN | A | NN`, in the 2026 one-line and two-row forms.
  static const MoroccoValidator standard = MoroccoValidator(
    fields: <MoroccoField>[
      MoroccoField('serial', 1, 5),
      MoroccoField('region', 1, 2),
    ],
    requiresSeries: true,
  );

  /// Six-digit service plates: government, police, auxiliary forces, civil
  /// protection, army.
  static const MoroccoValidator service = MoroccoValidator(
    fields: <MoroccoField>[MoroccoField('serial', 6, 6)],
  );

  /// Navy: four digits.
  static const MoroccoValidator navy = MoroccoValidator(
    fields: <MoroccoField>[MoroccoField('serial', 4, 4)],
  );

  /// `NNNN - NN`.
  static const MoroccoValidator trailer = MoroccoValidator(
    fields: <MoroccoField>[
      MoroccoField('serial', 4, 4),
      MoroccoField('region', 2, 2),
    ],
  );

  /// `NNNNN W 18`.
  static const MoroccoValidator dealer = MoroccoValidator(
    fields: <MoroccoField>[MoroccoField('serial', 5, 5)],
  );

  /// `NNNNNN WW`.
  static const MoroccoValidator temporary = MoroccoValidator(
    fields: <MoroccoField>[MoroccoField('serial', 6, 6)],
  );

  /// `NNN - NN` on the diplomatic and international cooperation plates.
  static const MoroccoValidator mission = MoroccoValidator(
    fields: <MoroccoField>[
      MoroccoField('serial', 3, 3),
      MoroccoField('country', 2, 2),
    ],
  );

  static String reasonFor(MoroccoField f) => f.min == f.max
      ? 'The ${f.group} is ${f.max} digits.'
      : 'The ${f.group} is ${f.min} to ${f.max} digits.';
  static const String reasonSeries = 'The series letter is missing.';
  static const String reasonZero = 'The number cannot be all zeros.';

  @override
  PlateValidation judge(PlateEntry entry) {
    for (final MoroccoField f in fields) {
      final String v = entry.group(f.group);
      if (v.length < f.min || v.length > f.max || !isDigits(v)) {
        return PlateValidation.invalid(reasonFor(f));
      }
      if (v.replaceAll('0', '').isEmpty) {
        return const PlateValidation.invalid(reasonZero);
      }
    }
    if (requiresSeries && entry.group('series').isEmpty) {
      return const PlateValidation.invalid(reasonSeries);
    }
    return const PlateValidation.valid();
  }
}
