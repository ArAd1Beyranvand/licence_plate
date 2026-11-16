from __future__ import annotations

import re
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


class CollectivityOfSaintMartinValidator(GatedPlateValidator):
    gate_group = "letters"
    reason_number = "The number is three or four digits."
    reason_letters = "The letters are two or three (no I, O, U or SS)."
    _number = re.compile(r"^[0-9]{3,4}$")
    _letters = re.compile(r"^[A-HJ-NP-TV-Z]{2,3}$")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not self._number.fullmatch(entry.group("number")):
            return PlateValidation.invalid(self.reason_number)
        letters = entry.group("letters")
        if not self._letters.fullmatch(letters) or "SS" in letters:
            return PlateValidation.invalid(self.reason_letters)
        return PlateValidation.valid()
