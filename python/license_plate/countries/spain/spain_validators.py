from __future__ import annotations

import re
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length


class SpainValidator(GatedPlateValidator):
    gate_group = 'number'

    _consonants = re.compile(r"^[BCDFGHJKLMNPRSTVWXYZ]{3}$")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        code = entry.group("code")
        if code:
            if code not in ("CD", "CC", "TA", "OI"):
                return PlateValidation.invalid("The prefix is CD, CC, TA or OI.")
            embassy = entry.group("embassy")
            if not is_digits(embassy) or len(embassy) > 3:
                return PlateValidation.invalid("The embassy code is one to three digits.")
            if not is_digits_of_length(entry.group("number"), 3):
                return PlateValidation.invalid("The car number is three digits.")
            return PlateValidation.valid()
        if not is_digits_of_length(entry.group("number"), 4):
            return PlateValidation.invalid("The number is four digits.")
        if not self._consonants.fullmatch(entry.group("letters")):
            return PlateValidation.invalid("The counter is three consonants (no vowels, no Q).")
        return PlateValidation.valid()
