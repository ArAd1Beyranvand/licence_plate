from __future__ import annotations

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length)


class SamoaValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_serial = "The number is one to four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        serial = entry.group("serial")
        if not serial or len(serial) > 4 or not is_digits(serial):
            return PlateValidation.invalid(self.reason_serial)
        mark = entry.group("mark") if any(g.key == "mark" for g in entry.spec.text_groups) else ""
        if mark and not is_digits_of_length(mark, 1):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()
