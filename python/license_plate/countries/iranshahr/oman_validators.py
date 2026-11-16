from __future__ import annotations

from plate_core import PlateEntry, PlateValidation


class OmanPlateValidator:
    def validate(self, entry: PlateEntry) -> PlateValidation:
        for group in entry.spec.text_groups:
            key = group.key
            if key is None:
                continue
            for i in group.indices:
                if not entry.spec.slots[i].is_complete(entry.values[i]):
                    return PlateValidation.invalid(f"The {key} is incomplete.")
        return PlateValidation.valid()
