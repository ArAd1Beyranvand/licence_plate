from __future__ import annotations

import re
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


class ChadValidator(GatedPlateValidator):
    gate_group = "number"
    _letter = re.compile(r"^[A-Z]$")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        region = entry.group("region")
        if not is_digits_of_length(region, 2):
            return PlateValidation.invalid("The region is 01 to 23.")
        region_int = int(region)
        if region_int < 1 or region_int > 23:
            return PlateValidation.invalid("The region is 01 to 23.")
        if not self._letter.fullmatch(entry.group("type")):
            return PlateValidation.invalid(
                "The vehicle type is 1 letter (B, C, M, P, S, T, V)."
            )
        if not is_digits_of_length(entry.group("number"), 4):
            return PlateValidation.invalid("The number is 4 digits.")
        tail = entry.group("tail")
        if tail and not self._letter.fullmatch(tail) and tail != "TT":
            return PlateValidation.invalid(
                "The series is 1 letter, or TT on a temporary plate."
            )
        return PlateValidation.valid()
