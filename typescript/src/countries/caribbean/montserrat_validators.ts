import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a Montserrat plate: a type letter and one to four digits (`M 1667`).
 * Reports, never bars a keystroke. */
export class MontserratValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('type', '[A-Z]', 'The type is one letter.'),
    new PlateCheck('serial', '[0-9]{1,4}', 'The number is one to four digits.'),
  ];
}
