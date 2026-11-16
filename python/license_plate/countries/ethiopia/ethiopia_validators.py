from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length)

_TWO_LETTERS = re.compile(r"[A-Z]{2}")
_REFUSED_MISSIONS = ("84",)
_NOT_FOUND = "COUNTRY NOT FOUND"


class EthiopiaValidator(GatedPlateValidator):
    gate_group = 'number'

    REASON_NUMBER = "The number is six digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if is_digits_of_length(entry.group("number"), 6):
            return PlateValidation.valid()
        return PlateValidation.invalid(self.REASON_NUMBER)


class EthiopiaRegionalValidator(GatedPlateValidator):
    gate_group = 'code'

    REASON_CLASS = "The class is one digit."
    REASON_GEEZ = "The region is two Ge'ez letters."
    REASON_NUMBER = "The number is six digits."
    REASON_CODE = "The region code is two letters."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not is_digits_of_length(entry.group("class"), 1):
            return PlateValidation.invalid(self.REASON_CLASS)
        if len(entry.group("geez")) != 2:
            return PlateValidation.invalid(self.REASON_GEEZ)
        if not is_digits_of_length(entry.group("number"), 6):
            return PlateValidation.invalid(self.REASON_NUMBER)
        if not _TWO_LETTERS.fullmatch(entry.group("code")):
            return PlateValidation.invalid(self.REASON_CODE)
        return PlateValidation.valid()


class EthiopiaDiplomaticValidator(GatedPlateValidator):
    gate_group = 'type'

    REASON_MISSION = "The mission code is two digits."
    REASON_GEEZ = "The series is two Ge'ez letters."
    REASON_NUMBER = "The number is four digits."
    REASON_TYPE = "The type is two letters."

    def validate(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("mission") in _REFUSED_MISSIONS:
            return PlateValidation.invalid(_NOT_FOUND)
        return super().validate(entry)

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not is_digits_of_length(entry.group("mission"), 2):
            return PlateValidation.invalid(self.REASON_MISSION)
        if len(entry.group("series")) != 2:
            return PlateValidation.invalid(self.REASON_GEEZ)
        if not is_digits_of_length(entry.group("number"), 4):
            return PlateValidation.invalid(self.REASON_NUMBER)
        if not _TWO_LETTERS.fullmatch(entry.group("type")):
            return PlateValidation.invalid(self.REASON_TYPE)
        return PlateValidation.valid()
