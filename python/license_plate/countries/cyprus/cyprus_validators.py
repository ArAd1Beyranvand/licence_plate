from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length


def _between(v: str, lo: int, hi: int) -> bool:
    return is_digits(v) and lo <= len(v) <= hi


class CyprusValidator(GatedPlateValidator):
    gate_group = "digits"
    reason_standard = "A plate is three letters, three digits."
    reason_trailer = "A trailer plate is P and five digits."
    reason_diplomatic = "A diplomatic plate is a two-digit code, CD, CC or AT, and 1-3 digits."
    reason_sba = "An SBA plate is SBAA and two digits."
    reason_dealer = "A dealer plate is the dealer number (1-2 digits) and a serial (1-3)."
    diplomatic_classes = ("CD", "CC", "AT")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        digits = entry.group("digits")
        spec_id = entry.spec.id
        if spec_id == "cy.trailer":
            ok, reason = is_digits_of_length(digits, 5), self.reason_trailer
        elif spec_id == "cy.sba":
            ok, reason = is_digits_of_length(digits, 2), self.reason_sba
        elif spec_id == "cy.diplomatic":
            ok = (is_digits_of_length(entry.group("code"), 2)
                  and entry.group("class") in self.diplomatic_classes and _between(digits, 1, 3))
            reason = self.reason_diplomatic
        elif spec_id == "cy.dealer":
            ok, reason = _between(entry.group("dealer"), 1, 2) and _between(digits, 1, 3), self.reason_dealer
        else:
            ok = re.fullmatch(r"[A-Z]{3}", entry.group("letters")) is not None and is_digits_of_length(digits, 3)
            reason = self.reason_standard
        return PlateValidation.valid() if ok else PlateValidation.invalid(reason)
