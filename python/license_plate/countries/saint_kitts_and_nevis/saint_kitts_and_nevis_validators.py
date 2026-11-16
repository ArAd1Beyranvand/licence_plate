from __future__ import annotations

import re
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


class SaintKittsAndNevisValidator(GatedPlateValidator):
    gate_group = "digits"
    reason = "A plate is one or two letters and one to four digits."
    _digits = re.compile(r"^[0-9]{1,4}$")
    _letters = re.compile(r"^[A-Z]{1,2}$")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return (
            PlateValidation.valid()
            if self._digits.fullmatch(entry.group("digits"))
            and self._letters.fullmatch(entry.group("letters"))
            else PlateValidation.invalid(self.reason)
        )
