package plates.countries.el_salvador

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a 1976 car plate: a class letter and four digits (`P-0000`). Reports, never bars a keystroke. */
class ElSalvadorValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("letter", "[A-Z]", "The class is one letter."),
        PlateCheck("serial", "[0-9]{4}", "The number is four digits."),
    )
}

/** Judges a 1976 motorcycle plate: a letter, one digit and three digits (`M-1-234`). */
class ElSalvadorMotorcycleValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("letter", "[A-Z]", "The class is one letter."),
        PlateCheck("series", "[0-9]{1}", "The series is one digit."),
        PlateCheck("serial", "[0-9]{3}", "The number is three digits."),
    )
}
