from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, PlateValidator, is_digits, is_digits_of_length, restriction_verdict)


class _SlotsValidator(GatedPlateValidator):
    gate_group = "digits"
    reason_field = "A field has the wrong length or characters."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec = entry.spec
        for slot, group in zip(spec.slots, spec.text_groups):
            v = entry.group(group.key)
            if not slot.accepts(v) or len(v) < slot.min_length or len(v) > slot.length:
                return PlateValidation.invalid(self.reason_field)
        return PlateValidation.valid()


class MacauValidator(_SlotsValidator):
    pass


class MacauMopedValidator(_SlotsValidator):
    pass


class MacauMainlandValidator(_SlotsValidator):
    pass
