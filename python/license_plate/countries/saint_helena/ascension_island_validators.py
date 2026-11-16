from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


class AscensionIslandValidator(GatedPlateValidator):
    gate_group = "digits"
    reason_field = "A field has the wrong length or characters."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec = entry.spec
        for i in range(len(spec.slots)):
            slot = spec.slots[i]
            v = entry.group(spec.text_groups[i].key)
            if not slot.accepts(v) or len(v) < slot.min_length or len(v) > slot.length:
                return PlateValidation.invalid(self.reason_field)
        return PlateValidation.valid()
