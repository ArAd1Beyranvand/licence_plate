from __future__ import annotations

from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


class TaiwanValidator(GatedPlateValidator):
    gate_group = "digits"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        reason = "Three letters and four digits."
        spec = entry.spec
        for i in range(len(spec.slots)):
            slot = spec.slots[i]
            v = entry.group(spec.text_groups[i].key)
            if not slot.accepts(v) or len(v) != slot.length:
                return PlateValidation.invalid(reason)
        return PlateValidation.valid()


class TaiwanLegacyValidator(TaiwanValidator):
    gate_group = "digits"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return super().judge(entry)


@dataclass(frozen=True)
class TaiwanProtocolValidator(GatedPlateValidator):
    min_digits: int
    max_digits: int
    gate_group = "digits"

    def __init__(self, min_digits: int = 2, max_digits: int = 3) -> None:
        object.__setattr__(self, "min_digits", min_digits)
        object.__setattr__(self, "max_digits", max_digits)

    def judge(self, entry: PlateEntry) -> PlateValidation:
        v = entry.group("digits")
        reason = "The number has the wrong length."
        if not entry.spec.slots[0].accepts(v) or len(v) < self.min_digits or len(v) > self.max_digits:
            return PlateValidation.invalid(reason)
        return PlateValidation.valid()
