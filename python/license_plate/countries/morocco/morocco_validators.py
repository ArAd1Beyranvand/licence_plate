from __future__ import annotations

from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


@dataclass(frozen=True)
class MoroccoValidator(GatedPlateValidator):
    """`fields` are dicts with `group`, `min` and `max`."""

    fields: tuple
    requires_series: bool = False
    gate_group = 'serial'

    REASON_SERIES = "The series letter is missing."
    REASON_ZERO = "The number cannot be all zeros."

    @staticmethod
    def reason_for(f) -> str:
        if f["min"] == f["max"]:
            return f"The {f['group']} is {f['max']} digits."
        return f"The {f['group']} is {f['min']} to {f['max']} digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        for f in self.fields:
            v = entry.group(f["group"])
            if not f["min"] <= len(v) <= f["max"] or not is_digits(v):
                return PlateValidation.invalid(self.reason_for(f))
            if not v.replace("0", ""):
                return PlateValidation.invalid(self.REASON_ZERO)
        if self.requires_series and not entry.group("series"):
            return PlateValidation.invalid(self.REASON_SERIES)
        return PlateValidation.valid()
