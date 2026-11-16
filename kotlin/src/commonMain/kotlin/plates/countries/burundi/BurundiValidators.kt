package plates.countries.burundi

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a Burundian plate: a letter, four digits and a letter, `A 0412 A`. Reports, never bars a keystroke. */
class BurundiValidator : RuledPlateValidator("number") {
    override val checks = listOf(
        PlateCheck("prefix", "[A-Z]", "The prefix is 1 letter."),
        PlateCheck("number", "[0-9]{4}", "The number is 4 digits."),
        PlateCheck("suffix", "[A-Z]", "The suffix is 1 letter."),
    )
}
