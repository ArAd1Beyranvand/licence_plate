import 'package:license_plate/core/plate_core.dart';

/// Judges `ABC 123` field by field: `lead` (letters) and `number` (digits).
/// Reports, never bars a keystroke.
///
/// The lengths and the fixed prefix differ by category, so each plate has its
/// own constructor.
class PapuaNewGuineaValidator extends GatedPlateValidator {
  const PapuaNewGuineaValidator({
    this.leadMin = 3,
    this.leadMax = 3,
    this.numberMin = 3,
    this.numberMax = 3,
    this.leadStartsWith,
  }) : super('number');

  /// `BAA-000`.
  const PapuaNewGuineaValidator.general() : this();

  /// `AA-000`.
  const PapuaNewGuineaValidator.motorcycle()
    : this(leadMin: 2, leadMax: 2, numberMin: 3, numberMax: 3);

  /// `TR-0001`.
  const PapuaNewGuineaValidator.trailer()
    : this(leadMin: 2, leadMax: 2, numberMin: 4, numberMax: 4);

  /// `T-0000`, then `T-00000` once 9999 was passed.
  const PapuaNewGuineaValidator.taxi()
    : this(
        leadMin: 1,
        leadMax: 1,
        numberMin: 4,
        numberMax: 5,
        leadStartsWith: 'T',
      );

  /// `H-0001`.
  const PapuaNewGuineaValidator.hire()
    : this(
        leadMin: 1,
        leadMax: 1,
        numberMin: 4,
        numberMax: 4,
        leadStartsWith: 'H',
      );

  /// `P-0000`.
  const PapuaNewGuineaValidator.publicMotorVehicle()
    : this(
        leadMin: 1,
        leadMax: 1,
        numberMin: 4,
        numberMax: 4,
        leadStartsWith: 'P',
      );

  /// `ZA-000` (motorcycles), `ZPD-000`.
  const PapuaNewGuineaValidator.government()
    : this(
        leadMin: 2,
        leadMax: 3,
        numberMin: 3,
        numberMax: 3,
        leadStartsWith: 'Z',
      );

  /// `PAA-000`.
  const PapuaNewGuineaValidator.provincial() : this(leadStartsWith: 'P');

  /// `CC-033`.
  const PapuaNewGuineaValidator.consular()
    : this(leadMin: 2, leadMax: 2, leadStartsWith: 'CC');

  /// `DC-053`.
  const PapuaNewGuineaValidator.diplomatic()
    : this(leadMin: 2, leadMax: 2, leadStartsWith: 'DC');

  /// `TT-3447`.
  const PapuaNewGuineaValidator.trade()
    : this(
        leadMin: 2,
        leadMax: 2,
        numberMin: 4,
        numberMax: 4,
        leadStartsWith: 'TT',
      );

  final int leadMin, leadMax, numberMin, numberMax;

  /// The fixed prefix of the category, or null.
  final String? leadStartsWith;

  @override
  PlateValidation judge(PlateEntry entry) {
    final String lead = entry.group('lead');
    if (!RegExp('^[A-Z]{$leadMin,$leadMax}\$').hasMatch(lead)) {
      return PlateValidation.invalid(
        leadMin == leadMax
            ? 'The letters are $leadMin.'
            : 'The letters are $leadMin to $leadMax.',
      );
    }
    final String? prefix = leadStartsWith;
    if (prefix != null && !lead.startsWith(prefix)) {
      return PlateValidation.invalid('The letters start with $prefix.');
    }
    if (!RegExp(
      '^[0-9]{$numberMin,$numberMax}\$',
    ).hasMatch(entry.group('number'))) {
      return PlateValidation.invalid(
        numberMin == numberMax
            ? 'The number is $numberMin digits.'
            : 'The number is $numberMin to $numberMax digits.',
      );
    }
    return const PlateValidation.valid();
  }
}
