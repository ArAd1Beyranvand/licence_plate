from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


class NorthernCyprusValidator(GatedPlateValidator):
    gate_group = "digits"
    reason_field = "A field has the wrong length or characters."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec = entry.spec
        for i, slot in enumerate(spec.slots):
            v = entry.group(spec.text_groups[i].key)
            if not slot.accepts(v) or len(v) < slot.min_length or len(v) > slot.length:
                return PlateValidation.invalid(self.reason_field)
        return PlateValidation.valid()
