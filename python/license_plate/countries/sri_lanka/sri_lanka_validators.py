from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, PlateValidator, is_digits, is_digits_of_length, restriction_verdict)


_LETTERS = re.compile(r"[A-Z]{2,3}")


class SriLankaValidator(GatedPlateValidator):
    gate_group = "number"
    reason_province = "The province is CP, EP, NC, NP, NW, SG, SP, UP or WP."
    reason_letters = "The series is two or three letters."
    reason_number = "The number is four digits."
    provinces = frozenset(("CP", "EP", "NC", "NP", "NW", "SG", "SP", "UP", "WP"))

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("province") not in self.provinces:
            return PlateValidation.invalid(self.reason_province)
        if not _LETTERS.fullmatch(entry.group("letters")):
            return PlateValidation.invalid(self.reason_letters)
        if not is_digits_of_length(entry.group("number"), 4):
            return PlateValidation.invalid(self.reason_number)
        return PlateValidation.valid()
