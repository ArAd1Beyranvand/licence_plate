import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a plate: two letters, the first always `P`, and four digits (`PA 1234`). Reports, never bars a keystroke. */
export class SurinameValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('letters', 'P[A-Z]', 'The register is two letters, the first one P.'),
    new PlateCheck('serial', '[0-9]{4}', 'The number is four digits.'),
  ];
}
