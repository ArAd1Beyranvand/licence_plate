from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


class AbkhaziaValidator(GatedPlateValidator):
    gate_group = "series"
    reason_field = "A field has the wrong length or letters."
    reason_number = "The diplomatic number is one digit after CD, three after D or T."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec = entry.spec
        for i in range(len(spec.slots)):
            slot = spec.slots[i]
            value = entry.group(spec.text_groups[i].key)
            whole = slot.alphabet.input == "chosen"
            if not slot.accepts(value) or (not whole and (len(value) < slot.min_length or len(value) > slot.length)):
                return PlateValidation.invalid(self.reason_field)
        if spec.id == "diplomatic":
            want = 1 if entry.group("status") == "CD" else 3
            if len(entry.group("number")) != want:
                return PlateValidation.invalid(self.reason_number)
        return PlateValidation.valid()
