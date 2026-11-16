from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length)


class PakistanValidator(GatedPlateValidator):
    gate_group = "digits"

    REASON_LETTERS = "The letters are two or three, none of I, O, U."
    REASON_DIGITS = "The number is three or four digits."
    REASON_YEAR = "The year is two digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not re.fullmatch(r"[A-HJ-NP-TV-Z]{2,3}", entry.group("letters")):
            return PlateValidation.invalid(self.REASON_LETTERS)
        digits = entry.group("digits")
        if not is_digits(digits) or not 3 <= len(digits) <= 4:
            return PlateValidation.invalid(self.REASON_DIGITS)
        year = entry.group("year")
        if year and not is_digits_of_length(year, 2):
            return PlateValidation.invalid(self.REASON_YEAR)
        return PlateValidation.valid()
