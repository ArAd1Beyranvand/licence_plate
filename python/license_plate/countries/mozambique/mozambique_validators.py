from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


@dataclass(frozen=True)
class MozambiqueValidator(GatedPlateValidator):
    gate_group = "number"
    reason_letters = "The series is three letters."
    reason_number = "The number is three digits."
    reason_province = "The province is CA, GZ, IB, MC, MP, MN, NP, NS, SF, TT or ZB."
    _letters = re.compile(r"^[A-Z]{3}$")
    province_codes = frozenset({"CA", "GZ", "IB", "MC", "MP", "MN", "NP", "NS", "SF", "TT", "ZB"})

    def judge(self, entry: PlateEntry) -> PlateValidation:
        letters = entry.group("letters")
        number = entry.group("number")
        province = entry.group("province")
        if not self._letters.fullmatch(letters):
            return PlateValidation.invalid(self.reason_letters)
        if not is_digits_of_length(number, 3):
            return PlateValidation.invalid(self.reason_number)
        if province not in self.province_codes:
            return PlateValidation.invalid(self.reason_province)
        return PlateValidation.valid()


@dataclass(frozen=True)
class MozambiqueLegacyValidator(GatedPlateValidator):
    gate_group = "first"
    reason_letters = "The series is M and two district letters."
    reason_digits = "The number is two pairs of digits."
    _letters = re.compile(r"^M[A-Z]{2}$")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        letters = entry.group("letters")
        first = entry.group("first")
        second = entry.group("second")
        if not self._letters.fullmatch(letters):
            return PlateValidation.invalid(self.reason_letters)
        if not is_digits_of_length(first, 2) or not is_digits_of_length(second, 2):
            return PlateValidation.invalid(self.reason_digits)
        return PlateValidation.valid()
