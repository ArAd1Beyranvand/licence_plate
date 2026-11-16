from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, PlateValidator, is_digits, is_digits_of_length, restriction_verdict)


_COUNTER = re.compile(r"[BCDFGHJKLMNPRSTVWXYZ]{3}")
_PREFIX = re.compile(r"[A-Z]{1,3}")


class MelillaValidator(GatedPlateValidator):
    gate_group = "number"
    reason_number = "The number is four digits."
    reason_letters = "The counter is three consonants (no vowels, no Q)."
    reason_code = "The prefix is CD, CC, TA or OI."
    reason_embassy = "The embassy code is one to three digits."
    reason_car = "The car number is three digits."
    reason_prefix = "The prefix is one to three letters."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        code = entry.group("code")
        if code:
            if code not in ("CD", "CC", "TA", "OI"):
                return PlateValidation.invalid(self.reason_code)
            embassy = entry.group("embassy")
            if not is_digits(embassy) or len(embassy) > 3:
                return PlateValidation.invalid(self.reason_embassy)
            if not is_digits_of_length(entry.group("number"), 3):
                return PlateValidation.invalid(self.reason_car)
            return PlateValidation.valid()
        if not is_digits_of_length(entry.group("number"), 4):
            return PlateValidation.invalid(self.reason_number)
        prefix = entry.group("prefix")
        if prefix:
            return PlateValidation.valid() if _PREFIX.fullmatch(prefix) else PlateValidation.invalid(self.reason_prefix)
        if not _COUNTER.fullmatch(entry.group("letters")):
            return PlateValidation.invalid(self.reason_letters)
        return PlateValidation.valid()
