import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges `AB-123-CD`: two letters, three digits, two letters. Reports, never
 * bars a keystroke. */
export class GabonValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('series', '[A-Z]{2}', 'The first group is 2 letters.'),
    new PlateCheck('number', '[0-9]{3}', 'The number is 3 digits.'),
    new PlateCheck('suffix', '[A-Z]{2}', 'The last group is 2 letters.'),
  ];

  override get gateGroup(): string {
    return 'number';
  }
}
