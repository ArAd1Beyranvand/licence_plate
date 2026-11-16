from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


class SouthOssetiaValidator(GatedPlateValidator):
    gate_group = "series"
    reason_field = "A field has the wrong length or letters."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec = entry.spec
        for i in range(len(spec.slots)):
            slot = spec.slots[i]
            value = entry.group(spec.text_groups[i].key)
            if not slot.accepts(value) or len(value) < slot.min_length or len(value) > slot.length:
                return PlateValidation.invalid(self.reason_field)
        return PlateValidation.valid()
