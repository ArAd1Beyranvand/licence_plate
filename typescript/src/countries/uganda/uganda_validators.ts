import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** A two-letter series (`UP` police, `UU` prisons) and a serial of four or
  five digits. Reports, never bars a keystroke. */
export class UgandaValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('series', '[A-Z]{2}', 'The series is two letters.'),
    new PlateCheck('number', '[0-9]{4,5}', 'The number is four or five digits.'),
  ];
}
