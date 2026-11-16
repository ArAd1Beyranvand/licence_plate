package plates.countries.georgia_country

import plates.core.validators.GatedPlateValidator
import plates.core.validators.PlateEntry
import plates.core.validators.PlateValidation

enum class GeorgiaFieldKind { DIGITS, LETTERS, ALPHANUMERIC }

/** One field's rule: its kind and its length range. */
class GeorgiaFieldRule(val key: String, val kind: GeorgiaFieldKind, val min: Int, val max: Int) {
    fun accepts(value: String): Boolean {
        if (value.length < min || value.length > max) return false
        return value.all {
            when (kind) {
                GeorgiaFieldKind.DIGITS -> it in '0'..'9'
                GeorgiaFieldKind.LETTERS -> it in 'A'..'Z'
                GeorgiaFieldKind.ALPHANUMERIC -> it in '0'..'9' || it in 'A'..'Z'
            }
        }
    }
}

/** Judges a Georgian plate field by field; reports, never bars a keystroke. Quiet until the last field has content. */
class GeorgiaCountryValidator(val rules: List<GeorgiaFieldRule>) : GatedPlateValidator() {
    override val gateGroup get() = rules.last().key

    override fun judge(entry: PlateEntry): PlateValidation {
        for (r in rules) if (!r.accepts(entry.group(r.key))) return PlateValidation.invalid(REASON)
        return PlateValidation.valid
    }

    companion object {
        const val REASON = "A field is the wrong length or has a wrong character for this plate."
    }
}
