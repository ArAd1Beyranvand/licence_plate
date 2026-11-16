from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits, restriction_verdict)

_FORBIDDEN = {"area": "IQZ", "random": "IQ"}


class UnitedKingdomValidator:
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
                bad = _FORBIDDEN.get(g.key, "")
                if bad and any(c in bad for c in value):
                    return PlateValidation.invalid(f"The {g.key} never uses {', '.join(bad)}.")
        return PlateValidation.valid()
