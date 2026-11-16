from __future__ import annotations

from plate_core import PlateEntry, PlateValidation, restriction_verdict


class SaintHelenaValidator:
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
        return PlateValidation.valid()
