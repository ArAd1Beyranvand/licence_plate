from __future__ import annotations

from plate_core import PlateEntry, PlateValidation


class JerseyValidator:
    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        serial = entry.values[0] if entry.values else ""
        if not serial:
            return PlateValidation.valid()
        slot = entry.spec.slot_at(0)
        if slot is not None and not slot.is_complete(serial):
            return PlateValidation.invalid("The serial is incomplete.")
        return PlateValidation.valid()


def restriction_verdict(entry: PlateEntry) -> PlateValidation | None:
    # Placeholder for any external restriction logic if needed.
    # Based on the Dart stub, this function returns a PlateValidation if a restriction applies,
    # or None if the check passes.
    return None
