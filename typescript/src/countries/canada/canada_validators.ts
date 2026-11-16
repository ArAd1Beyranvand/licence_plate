import { GatedPlateValidator, PlateCheck, type PlateEntry, type PlateValidation, RuledPlateValidator, invalid, isDigitsOfLength, valid } from 'plate_core';

/** Judges a `CanadaPlates.federal` value: five digits. Reports, never bars a
 * keystroke. */
export class CanadaFederalValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('number', '[0-9]{5}', 'A federal plate has five digits.'),
  ];
}

/** Judges a `CanadaPlates.permit` value: a letter, then six digits. I, O, Q
 * and U are reported as unused. */
export class CanadaPermitValidator extends GatedPlateValidator {
  readonly gateGroup = 'letter';

  static readonly reasonLetter = 'A permit starts with one letter.';
  static readonly reasonUnused = 'I, O, Q and U are not used in serials.';
  static readonly reasonNumber = 'A permit has six digits.';

  judge(entry: PlateEntry): PlateValidation {
    const letter = entry.group('letter');
    if (letter.length !== 1) {
      return invalid(CanadaPermitValidator.reasonLetter);
    }
    if ('IOQU'.includes(letter)) {
      return invalid(CanadaPermitValidator.reasonUnused);
    }
    if (!isDigitsOfLength(entry.group('number'), 6)) {
      return invalid(CanadaPermitValidator.reasonNumber);
    }
    return valid;
  }
}
