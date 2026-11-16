package plates.countries.lesotho

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Advisory validator for `A 1705`: one or two letters, four digits. */
class LesothoValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("letters", "[A-Z]{1,2}", "The prefix is one or two letters."),
        PlateCheck("serial", "[0-9]{4}", "The number is four digits."),
    )
}
