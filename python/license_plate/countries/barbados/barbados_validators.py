from __future__ import annotations

import re
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


class BarbadosValidator(GatedPlateValidator):
    gate_group = "digits"
    _digits = re.compile(r"^[0-9]{1,4}$")
    _letters = re.compile(r"^[A-Z]{1,2}$")
    reason = "A plate is one or two letters and one to four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        digits = entry.group("digits")
        letters = entry.group("letters")
        if self._digits.fullmatch(digits) and self._letters.fullmatch(letters):
            return PlateValidation.valid()
        return PlateValidation.invalid(self.reason)
