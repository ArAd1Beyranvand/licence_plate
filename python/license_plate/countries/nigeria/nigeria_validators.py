from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, PlateValidator, is_digits, is_digits_of_length, restriction_verdict)


_AREA = re.compile(r"[A-Z]{3}")
_SUFFIX = re.compile(r"[A-Z]{2}")


class NigeriaValidator(GatedPlateValidator):
    gate_group = "suffix"
    reason_area = "The area code is three letters."
    reason_serial = "The number is three digits."
    reason_suffix = "The suffix is two letters."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not _AREA.fullmatch(entry.group("area")):
            return PlateValidation.invalid(self.reason_area)
        if not is_digits_of_length(entry.group("serial"), 3):
            return PlateValidation.invalid(self.reason_serial)
        if not _SUFFIX.fullmatch(entry.group("suffix")):
            return PlateValidation.invalid(self.reason_suffix)
        return PlateValidation.valid()
