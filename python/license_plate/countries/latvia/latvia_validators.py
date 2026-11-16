from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, PlateValidator, is_digits, is_digits_of_length, restriction_verdict)


class LatviaValidator:
    reason_regular = "Two letters, then one to four digits."
    reason_diplomatic = "CD, then four digits."

    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        letters = entry.group("letters")
        number = entry.group("number")
        if not letters or not number:
            return PlateValidation.valid()
        if entry.spec.id == "lv.diplomatic":
            if letters in ("CD", "C") and is_digits_of_length(number, 4):
                return PlateValidation.valid()
            return PlateValidation.invalid(self.reason_diplomatic)
        if len(letters) != 2 or not is_digits(number):
            return PlateValidation.invalid(self.reason_regular)
        return PlateValidation.valid()
