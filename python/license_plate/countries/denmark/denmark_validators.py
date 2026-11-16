from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length)

_LETTERS = re.compile(r"[A-Z]{2}")
_VANITY = re.compile(r"[A-ZÆØÅ0-9]{2,7}")


@dataclass(frozen=True)
class DenmarkValidator(GatedPlateValidator):
    year_digits: int = 0
    mid_digits: int = 2
    number_digits: int = 3
    allowed_letters: tuple | None = None
    gate_group = 'number'

    REASON_LETTERS = "The letters are two of A–Z."
    REASON_GREENLAND = "Greenland uses the letters GR or GL."
    REASON_DIGITS = "The digits do not fit the plate."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        letters = entry.group("letters")
        has_letters = self.year_digits == 0
        if has_letters and not _LETTERS.fullmatch(letters):
            return PlateValidation.invalid(self.REASON_LETTERS)
        if has_letters and self.allowed_letters is not None and letters not in self.allowed_letters:
            return PlateValidation.invalid(self.REASON_GREENLAND)
        if ((self.year_digits > 0 and not is_digits_of_length(entry.group("year"), self.year_digits))
                or (self.mid_digits > 0 and not is_digits_of_length(entry.group("mid"), self.mid_digits))
                or not is_digits_of_length(entry.group("number"), self.number_digits)):
            return PlateValidation.invalid(self.REASON_DIGITS)
        return PlateValidation.valid()


class DenmarkVanityValidator(GatedPlateValidator):
    gate_group = 'text'

    REASON_TEXT = "A vanity plate is two to seven letters or digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if _VANITY.fullmatch(entry.group("text")):
            return PlateValidation.valid()
        return PlateValidation.invalid(self.REASON_TEXT)
