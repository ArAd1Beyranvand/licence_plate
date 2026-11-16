from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, restriction_verdict)


class GuyanaValidator(GatedPlateValidator):
    gate_group = "number"

    MIN_LETTERS = 2
    MAX_LETTERS = 3
    MAX_DIGITS = 4

    REASON_LETTERS = "The series is two or three letters."
    REASON_NUMBER = "The number is one to four digits, with no leading zero."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return self.validate_fields(entry.group("letters"), entry.group("number"))

    @staticmethod
    def validate_fields(letters: str, number: str) -> PlateValidation:
        if not re.fullmatch(r"[A-Z]{2,3}", letters):
            return PlateValidation.invalid(GuyanaValidator.REASON_LETTERS)
        if not re.fullmatch(r"[1-9][0-9]{0,3}", number):
            return PlateValidation.invalid(GuyanaValidator.REASON_NUMBER)
        return PlateValidation.valid()


class GuyanaVehicleTypes:
    names = {
        "P": "Private",
        "H": "Hire / taxi",
        "B": "Bus",
        "G": "Goods (powered trade vehicle)",
        "C": "Cycle",
        "T": "Trailer (non-powered trade vehicle)",
    }
