package plates.countries.uruguay

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/**
 * Judges a Uruguayan serial `A BC 1234`: three letters in `first`, the first
 * a department code (A to S), and one to four digits in `number`.
 * The category letters are not checked. Reports, never bars a keystroke.
 */
class UruguayValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("first", "[A-S][A-Z]{2}", "A serial is three letters, the first a department code (A to S)."),
        PlateCheck("number", "[0-9]{1,4}", "The number is one to four digits."),
    )
}
