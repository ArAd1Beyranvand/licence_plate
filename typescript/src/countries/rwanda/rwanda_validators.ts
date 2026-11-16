import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a plate `RXX ###X`: a register of three letters starting with `R`,
 * then three digits and a letter. Reports, never bars a keystroke. */
export class RwandaValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('register', 'R[A-Z]{2}', 'The register is three letters starting with R.'),
    new PlateCheck('serial', '[0-9]{3}[A-Z]', 'The number is three digits and a letter.'),
  ];
}
