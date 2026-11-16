import { GatedPlateValidator, PlateCheck, type PlateEntry, type PlateValidation, RuledPlateValidator, invalid, valid } from 'plate_core';

/** Judges a [TurksAndCaicosIslandsPlates.modern] plate: five digits. Reports,
 * never bars a keystroke. */
export class TurksAndCaicosIslandsValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('serial', '[0-9]{5}', 'The number is five digits.'),
  ];
}

/** Judges a [TurksAndCaicosIslandsPlates.prefixed] or `selfDrive` plate:
 * `TC` and one to five digits. */
export class TurksAndCaicosIslandsPrefixedValidator extends GatedPlateValidator {
  readonly gateGroup = 'serial';

  static readonly reasonPrefix = 'The plate starts with TC.';
  static readonly reasonSerial = 'The number is one to five digits.';

  judge(entry: PlateEntry): PlateValidation {
    if (entry.group('prefix') !== 'TC') {
      return invalid(TurksAndCaicosIslandsPrefixedValidator.reasonPrefix);
    }
    if (!/^([0-9]{1,5})$/.test(entry.group('serial')!)) {
      return invalid(TurksAndCaicosIslandsPrefixedValidator.reasonSerial);
    }
    return valid;
  }
}
