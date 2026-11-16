from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


@dataclass(frozen=True)
class CameroonValidator(GatedPlateValidator):
    gate_group = "number"
    regions = {"AD", "CE", "EN", "ES", "LT", "NO", "NW", "OU", "SU", "SW"}

    def judge(self, entry: PlateEntry) -> PlateValidation:
        region = entry.group("region")
        if region not in self.regions:
            return PlateValidation.invalid("The region is one of the ten region codes.")
        number = entry.group("number")
        if not (is_digits_of_length(number, 3) or is_digits_of_length(number, 4)):
            return PlateValidation.invalid("The number is three or four digits.")
        series = entry.group("series")
        if not series or len(series) > 2:
            return PlateValidation.invalid("The series is one or two letters.")
        if not all(c in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" for c in series):
            return PlateValidation.invalid("The series is one or two letters.")
        return PlateValidation.valid()


@dataclass(frozen=True)
class CameroonDiplomaticValidator(GatedPlateValidator):
    gate_group = "number"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        mission = entry.group("mission")
        plate_type = entry.group("type")
        if mission != "CM" or plate_type != "D":
            return PlateValidation.invalid("The prefix is CMD.")
        number = entry.group("number")
        if not is_digits_of_length(number, 2):
            return PlateValidation.invalid("The mission code is two digits.")
        suffix = entry.group("suffix")
        if not is_digits_of_length(suffix, 1):
            return PlateValidation.invalid("The suffix is one digit.")
        return PlateValidation.valid()
