from __future__ import annotations

from dataclasses import dataclass

from plate_core import PlateEntry, PlateValidation, restriction_verdict


@dataclass(frozen=True)
class IsleOfManValidator:
    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        if all(not v for v in entry.values):
            return PlateValidation.valid()
        for g in entry.spec.effective_text_groups:
            for i in g.indices:
                slot = entry.spec.slot_at(i)
                value = (entry.values[i] or '') if i < len(entry.values) else ''
                if slot is not None and not slot.is_complete(value):
                    return PlateValidation.invalid(f"The {g.key or 'field'} is incomplete.")
                if g.key == 'prefix':
                    if value.startswith('A'):
                        return PlateValidation.invalid('The first letter is never A.')
                    if value[1:] != 'MN':
                        return PlateValidation.invalid('The prefix is a letter followed by MN.')
        return PlateValidation.valid()
