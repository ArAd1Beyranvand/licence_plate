from __future__ import annotations

from plate_core import AlphabetInput
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation

from .russia_missions import _MISSIONS
from .russia_regions import CODES, MILITARY_CODES


class RussiaValidator(GatedPlateValidator):
    gate_group = "region"

    REASON_FIELD = "A field has the wrong length or letters."
    REASON_REGION = "The region code is not in use."
    REASON_MISSION = "The mission code is not in use."
    REASON_NUMBER = "The diplomatic number is one digit after CD, three after D or T."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec = entry.spec
        for slot, group in zip(spec.slots, spec.text_groups):
            value = entry.group(group.key)
            whole = slot.alphabet.input is AlphabetInput.CHOSEN
            if not slot.accepts(value) or (not whole and not slot.min_length <= len(value) <= slot.length):
                return PlateValidation.invalid(self.REASON_FIELD)
        region = entry.group("region")
        if spec.id == "ru.diplomatic":
            if entry.group("code") not in _MISSIONS:
                return PlateValidation.invalid(self.REASON_MISSION)
            if len(entry.group("number")) != (1 if entry.group("status") == "CD" else 3):
                return PlateValidation.invalid(self.REASON_NUMBER)
        known = region in (MILITARY_CODES if spec.id == "ru.military" else CODES)
        return PlateValidation.valid() if known else PlateValidation.invalid(self.REASON_REGION)
