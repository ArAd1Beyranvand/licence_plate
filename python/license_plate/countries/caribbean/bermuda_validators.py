from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateCheck, PlateEntry, PlateValidation, RuledPlateValidator, is_digits_of_length


@dataclass(frozen=True)
class BermudaValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_serial = "The number is five digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return (
            PlateValidation.valid()
            if is_digits_of_length(entry.group("serial"), 5)
            else PlateValidation.invalid(self.reason_serial)
        )


@dataclass(frozen=True)
class BermudaPrefixedValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_letters = "The class prefix is one to three letters."
    reason_serial = "The number is three or four digits."

    _letters = re.compile(r"^[A-Z]{1,3}$")
    _serial = re.compile(r"^[0-9]{3,4}$")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not self._letters.fullmatch(entry.group("letters")):
            return PlateValidation.invalid(self.reason_letters)
        if not self._serial.fullmatch(entry.group("serial")):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()


class BermudaSuffixedValidator(RuledPlateValidator):
    checks = (
        PlateCheck("serial", r"[0-9]{3}", "The number is three digits."),
        PlateCheck("letter", r"[A-Z]", "The suffix is one letter."),
    )
