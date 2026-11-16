import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a 2017 plate: three digits, then one or two letters (`560 AT`). Reports, never bars a keystroke. */
export class SouthSudanValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('serial', '[0-9]{3}', 'The number is three digits.'),
    new PlateCheck('letters', '[A-Z]{1,2}', 'The register is one or two letters.'),
  ];
}
