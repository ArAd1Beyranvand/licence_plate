from __future__ import annotations

from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateCheck, PlateEntry, PlateValidation, RuledPlateValidator, is_digits_of_length


class CanadaFederalValidator(RuledPlateValidator):
    checks = (
        PlateCheck("number", r"[0-9]{5}", "A federal plate has five digits."),
    )


@dataclass(frozen=True)
class CanadaPermitValidator(GatedPlateValidator):
    gate_group = "letter"
    reason_letter = "A permit starts with one letter."
    reason_unused = "I, O, Q and U are not used in serials."
    reason_number = "A permit has six digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        letter = entry.group("letter")
        if len(letter) != 1:
            return PlateValidation.invalid(self.reason_letter)
        if letter in "IOQU":
            return PlateValidation.invalid(self.reason_unused)
        if not is_digits_of_length(entry.group("number"), 6):
            return PlateValidation.invalid(self.reason_number)
        return PlateValidation.valid()
