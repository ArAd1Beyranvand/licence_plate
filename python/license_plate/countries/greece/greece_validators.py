from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


class GreeceValidator(GatedPlateValidator):
    gate_group = "number"

    REASON_LETTERS = "The prefix is letters from Α Β Ε Ζ Η Ι Κ Μ Ν Ο Ρ Τ Υ Χ."
    REASON_DIGITS = "The number has the wrong digit count."
    REASON_RANGE = "Private numbers run from 1000 to 9999."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec = entry.spec
        (li,) = spec.indices_of_group("letters")
        (ni,) = spec.indices_of_group("number")
        letters, number = spec.slots[li], spec.slots[ni]
        prefix, digits = entry.group("letters"), entry.group("number")
        if not letters.min_length <= len(prefix) <= letters.length or not letters.accepts(prefix):
            return PlateValidation.invalid(self.REASON_LETTERS)
        if not is_digits(digits) or not number.min_length <= len(digits) <= number.length:
            return PlateValidation.invalid(self.REASON_DIGITS)
        if spec.id == "gr.private" and int(digits) < 1000:
            return PlateValidation.invalid(self.REASON_RANGE)
        return PlateValidation.valid()
