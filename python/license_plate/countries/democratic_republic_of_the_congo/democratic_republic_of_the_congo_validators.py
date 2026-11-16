from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length


class DemocraticRepublicOfTheCongoValidator(GatedPlateValidator):
    gate_group = 'province'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not is_digits_of_length(entry.group("number"), 4):
            return PlateValidation.invalid("The number is 4 digits.")
        if re.fullmatch(r"[A-Z]{2}", entry.group("series")) is None:
            return PlateValidation.invalid("The series is 2 letters.")
        province = entry.group("province")
        if not (len(province) == 2 and is_digits(province) and 1 <= int(province) <= 26):
            return PlateValidation.invalid("The province code is 01 to 26.")
        return PlateValidation.valid()
