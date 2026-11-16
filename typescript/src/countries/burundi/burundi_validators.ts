import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a Burundian plate: a letter, four digits and a letter,
 * `A 0412 A`. Reports, never bars a keystroke.
 *
 * The format is read off two street photographs (`B·6232·A`, `A·0412·A`);
 * the article gives only "not standard". */
export class BurundiValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('prefix', '[A-Z]', 'The prefix is 1 letter.'),
    new PlateCheck('number', '[0-9]{4}', 'The number is 4 digits.'),
    new PlateCheck('suffix', '[A-Z]', 'The suffix is 1 letter.'),
  ];

  override get gateGroup(): string {
    return 'number';
  }
}
