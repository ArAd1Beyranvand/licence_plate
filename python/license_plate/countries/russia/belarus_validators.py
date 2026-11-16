from __future__ import annotations

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length)

from .belarus_missions import BelarusMissions


class BelarusPlateValidator(GatedPlateValidator):
    gate_group = "region"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        for g in entry.spec.text_groups:
            if g.key is not None and len(entry.group(g.key)) != len(g.indices):
                return PlateValidation.invalid(f"The {g.key} is incomplete.")
        return PlateValidation.valid()


class BelarusDiplomaticValidator(BelarusPlateValidator):
    def validate(self, entry: PlateEntry) -> PlateValidation:
        if BelarusMissions.is_refused(entry.group("mission")):
            return PlateValidation.invalid(BelarusMissions.not_found)
        return super().validate(entry)

    def judge(self, entry: PlateEntry) -> PlateValidation:
        verdict = super().judge(entry)
        if not verdict.is_valid:
            return verdict
        if BelarusMissions.name(entry.group("mission")) is None:
            return PlateValidation.invalid(BelarusMissions.not_found)
        return verdict


class BelarusServiceValidator(GatedPlateValidator):
    gate_group = "letters"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if is_digits_of_length(entry.group("serial"), 4):
            return PlateValidation.valid()
        return PlateValidation.invalid("The serial is incomplete.")
