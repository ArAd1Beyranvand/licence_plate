from __future__ import annotations

import re
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


class SaintLuciaValidator(GatedPlateValidator):
    gate_group = "digits"
    _digits = re.compile(r"^[0-9]{1,4}$")
    _letters = re.compile(r"^[A-Z]{1,3}$")
    reason = "A plate is a one to three letter prefix and one to four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        digits = entry.group("digits")
        letters = entry.group("letters")
        return (
            PlateValidation.valid()
            if self._digits.fullmatch(digits) and self._letters.fullmatch(letters)
            else PlateValidation.invalid(self.reason)
        )
