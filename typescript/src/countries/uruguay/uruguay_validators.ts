import { PlateCheck, RuledPlateValidator } from 'plate_core';

/**
 * Judges a Uruguayan serial `A BC 1234`: three letters in `first`, the first
 * a department code (A to S), and one to four digits in `number` (the
 * President of a Departmental Assembly's plate carries one).
 *
 * The category letters are not checked. Reports, never bars a keystroke.
 */
export class UruguayValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('first', '[A-S][A-Z]{2}', 'A serial is three letters, the first a department code (A to S).'),
    new PlateCheck('number', '[0-9]{1,4}', 'The number is one to four digits.'),
  ];
}
