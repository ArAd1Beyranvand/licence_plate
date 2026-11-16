from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, PlateValidator, is_digits, is_digits_of_length, restriction_verdict)



class GibraltarValidator:
    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        if all(not v for v in entry.values):
            return PlateValidation.valid()
        for g in entry.spec.effective_text_groups:
            for i in g.indices:
                slot = entry.spec.slot_at(i)
                value = (entry.values[i] or "") if i < len(entry.values) else ""
                if slot is not None and not slot.is_complete(value):
                    return PlateValidation.invalid(f"The {g.key or 'field'} is incomplete.")
                if g.key == "prefix" and value not in ("G", "GT"):
                    return PlateValidation.invalid("The prefix is G or GT.")
                if g.key == "serial" and entry.spec.id == "gi.private" and len(value) == 4 and value.startswith("0"):
                    return PlateValidation.invalid("A four-digit serial runs 1000 to 9999.")
        return PlateValidation.valid()
