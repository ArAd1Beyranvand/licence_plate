from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, PlateValidator, is_digits, is_digits_of_length, restriction_verdict)


_LETTERS = re.compile(r"[A-HJ-PR-UW-Z]{3}")
_LAST = re.compile(r"[0-9]{2}[0-9A-HJ-NPR-UW-Z]")
_MISSION = re.compile(r"[A-HJ-NPR-UW-Z]{2}")
_STATUS = re.compile(r"[A-I]")


class SwedenValidator(GatedPlateValidator):
    gate_group = "number"
    reason_letters = "The letters are three, none of I, Q, V, Å, Ä, Ö."
    reason_number = "The number is two digits and a digit or a letter (not O)."
    reason_digits = "The number is three digits."
    reason_code = "The mission code is two letters (no I, O, Q, V)."
    reason_status = "The status letter is A to I."
    reason_military = "The number is four to six digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        number = entry.group("number")
        code = entry.group("code")
        if code:
            if not _MISSION.fullmatch(code):
                return PlateValidation.invalid(self.reason_code)
            if not is_digits_of_length(number, 3):
                return PlateValidation.invalid(self.reason_digits)
            if not _STATUS.fullmatch(entry.group("status")):
                return PlateValidation.invalid(self.reason_status)
            return PlateValidation.valid()
        letters = entry.group("letters")
        if not letters:
            if not is_digits(number) or not 4 <= len(number) <= 6:
                return PlateValidation.invalid(self.reason_military)
            return PlateValidation.valid()
        if not _LETTERS.fullmatch(letters):
            return PlateValidation.invalid(self.reason_letters)
        if not is_digits_of_length(number, 3) and not _LAST.fullmatch(number):
            return PlateValidation.invalid(self.reason_number)
        return PlateValidation.valid()
