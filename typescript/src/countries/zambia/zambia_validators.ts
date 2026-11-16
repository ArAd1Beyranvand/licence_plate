import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges the plate (`ADD 4077 T`): three letters, four digits, one letter.
 * Reports, never bars a keystroke. */
export class ZambiaValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('prefix', '[A-Z]{3}', 'The prefix is three letters.'),
    new PlateCheck('serial', '[0-9]{4}', 'The number is four digits.'),
    new PlateCheck('suffix', '[A-Z]', 'The suffix is one letter.'),
  ];

  override get gateGroup(): string {
    return 'serial';
  }
}
