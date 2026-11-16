from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length)

_PROVINCES = ("AN", "BN", "BS", "CS", "KN", "LT", "WN")
_SERIES = re.compile(r"[A-Z]")


class EquatorialGuineaValidator(GatedPlateValidator):
    gate_group = 'series'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("province") not in _PROVINCES:
            return PlateValidation.invalid(f"The province is one of {', '.join(_PROVINCES)}.")
        if not is_digits_of_length(entry.group("number"), 3):
            return PlateValidation.invalid("The number is 3 digits.")
        if not _SERIES.fullmatch(entry.group("series")):
            return PlateValidation.invalid("The series is 1 letter.")
        return PlateValidation.valid()
