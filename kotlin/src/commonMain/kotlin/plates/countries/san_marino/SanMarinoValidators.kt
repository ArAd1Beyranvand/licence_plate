package plates.countries.san_marino

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a San Marino plate: a `prefix` of one to seven letters and a `number` of one to four digits. */
class SanMarinoValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("prefix", "[A-Z]{1,7}", "The prefix is one to seven letters."),
        PlateCheck("number", "[0-9]{1,4}", "The number is one to four digits."),
    )
}
