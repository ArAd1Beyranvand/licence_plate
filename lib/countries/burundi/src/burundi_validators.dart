import 'package:license_plate/core/plate_core.dart';

/// Judges a Burundian plate: a letter, four digits and a letter,
/// `A 0412 A`. Reports, never bars a keystroke.
///
/// The format is read off two street photographs (`B·6232·A`, `A·0412·A`);
/// the article gives only "not standard".
class BurundiValidator extends RuledPlateValidator {
  const BurundiValidator() : super('number');

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('prefix', r'[A-Z]', 'The prefix is 1 letter.'),
    PlateCheck('number', r'[0-9]{4}', 'The number is 4 digits.'),
    PlateCheck('suffix', r'[A-Z]', 'The suffix is 1 letter.'),
  ];
}
