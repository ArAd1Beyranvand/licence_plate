import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a plate (`S 11111`): one letter and up to five digits. The tag of
 * the plate since 2018 is not judged. Reports, never bars a keystroke. */
export class SeychellesValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('letter', '[A-Z]', 'The series is one letter.'),
    new PlateCheck('serial', '[0-9]{1,5}', 'The number is one to five digits.'),
  ];
}
