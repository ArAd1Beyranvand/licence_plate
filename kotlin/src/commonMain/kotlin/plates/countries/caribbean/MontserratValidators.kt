package plates.countries.caribbean

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a Montserrat plate: a type letter and one to four digits (`M 1667`). */
class MontserratValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("type", "[A-Z]", "The type is one letter."),
        PlateCheck("serial", "[0-9]{1,4}", "The number is one to four digits."),
    )
}
