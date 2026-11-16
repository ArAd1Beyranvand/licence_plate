from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length)

_TWO_OR_THREE_LETTERS = re.compile(r"[A-Z]{2,3}")
_INT = re.compile(r"[+-]?[0-9]+")
_REGION_CODES = tuple(f"{i:02d}" for i in range(1, 12))
_FOREIGN_CLASSES = ("H", "K", "M", "P")
_DIPLOMATIC_CLASSES = ("C", "D", "T")
_MISSION_CODES = tuple(f"{i:02d}" for i in range(1, 20)) + tuple(str(i) for i in range(50, 65))


def _month(value: str) -> bool:
    return len(value) == 2 and _INT.fullmatch(value) is not None and 1 <= int(value) <= 12


class KyrgyzstanValidator(GatedPlateValidator):
    gate_group = 'letters'

    REASON_REGION = "The region code is 01 to 11."
    REASON_NUMBER = "The number is three digits."
    REASON_LETTERS = "The serial ends in two or three letters."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("region") not in _REGION_CODES:
            return PlateValidation.invalid(self.REASON_REGION)
        if not is_digits_of_length(entry.group("number"), 3):
            return PlateValidation.invalid(self.REASON_NUMBER)
        if not _TWO_OR_THREE_LETTERS.fullmatch(entry.group("letters")):
            return PlateValidation.invalid(self.REASON_LETTERS)
        return PlateValidation.valid()


class KyrgyzstanForeignValidator(GatedPlateValidator):
    gate_group = 'letters'

    REASON_REGION = "The region code is 01 to 11."
    REASON_NUMBER = "The number is four digits."
    REASON_LETTER = "The class letter is H, K, M or P."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("region") not in _REGION_CODES:
            return PlateValidation.invalid(self.REASON_REGION)
        if not is_digits_of_length(entry.group("number"), 4):
            return PlateValidation.invalid(self.REASON_NUMBER)
        if entry.group("letters") not in _FOREIGN_CLASSES:
            return PlateValidation.invalid(self.REASON_LETTER)
        return PlateValidation.valid()


@dataclass(frozen=True)
class KyrgyzstanDiplomaticValidator(GatedPlateValidator):
    classes: tuple
    number_length: int
    has_mission: bool = False
    dated: bool = False
    gate_group = 'number'

    REASON_CLASS = "The class is not one this plate uses."
    REASON_MISSION = "The mission code is 01 to 19 (countries) or 50 to 64 (organisations)."
    REASON_NUMBER = "The number has the wrong length."
    REASON_MONTH = "The month is 01 to 12."
    REASON_YEAR = "The year is two digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("class") not in self.classes:
            return PlateValidation.invalid(self.REASON_CLASS)
        if self.has_mission and entry.group("mission") not in _MISSION_CODES:
            return PlateValidation.invalid(self.REASON_MISSION)
        if not is_digits_of_length(entry.group("number"), self.number_length):
            return PlateValidation.invalid(self.REASON_NUMBER)
        if self.dated:
            if not _month(entry.group("month")):
                return PlateValidation.invalid(self.REASON_MONTH)
            if not is_digits_of_length(entry.group("year"), 2):
                return PlateValidation.invalid(self.REASON_YEAR)
        return PlateValidation.valid()
