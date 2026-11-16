from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, PlateValidator, is_digits, is_digits_of_length, restriction_verdict)


class HaitiValidator(GatedPlateValidator):
    gate_group = "number"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec = entry.spec
        for g in spec.text_groups:
            key = g.key
            slot = spec.slots[spec.indices_of_group(key)[0]]
            value = entry.group(key)
            kind = "letters" if key == "series" else "digits"
            fits = (slot.min_length <= len(value) <= slot.length
                    and all(slot.alphabet.accepts(c) for c in value))
            if not fits:
                if slot.min_length == slot.length:
                    return PlateValidation.invalid(f"The {key} is {slot.length} {kind}.")
                return PlateValidation.invalid(f"The {key} is {slot.min_length} to {slot.length} {kind}.")
        return PlateValidation.valid()
