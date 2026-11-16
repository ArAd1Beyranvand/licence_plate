package plates.countries.guatemala

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a Guatemalan serial `P 123 ABC`: a class letter, three digits and three letters. Reports, never bars a keystroke. */
class GuatemalaValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("class", "[A-Z]", "The class is one letter, such as P or C."),
        PlateCheck("digits", "[0-9]{3}", "The number is three digits."),
        PlateCheck("letters", "[A-Z]{3}", "The serial ends in three letters."),
    )
}
