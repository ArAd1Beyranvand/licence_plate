package plates.countries.zambia

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges the plate (`ADD 4077 T`): three letters, four digits, one letter. Reports, never bars a keystroke. */
class ZambiaValidator : RuledPlateValidator("serial") {
    override val checks = listOf(
        PlateCheck("prefix", "[A-Z]{3}", "The prefix is three letters."),
        PlateCheck("serial", "[0-9]{4}", "The number is four digits."),
        PlateCheck("suffix", "[A-Z]", "The suffix is one letter."),
    )
}
