from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length

_REGION_CODES = frozenset((
    "A B BH BP BT E EB EH K KH M H OB P PA PB PK PP C CA CB CH CM CO CC CT T TX Y X").split())
_NOT_FOUND = "COUNTRY NOT FOUND"
_REFUSED = ("22",)


class BulgariaValidator(GatedPlateValidator):
    gate_group = "series"
    reason_region = "The province code is not one of the table."
    reason_number = "The number is four digits."
    reason_series = "The series is one or two of A B K M H P C T X."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        region = entry.group("region")
        if region not in _REGION_CODES and region not in ("EA", "EM"):
            return PlateValidation.invalid(self.reason_region)
        if not is_digits_of_length(entry.group("number"), 4):
            return PlateValidation.invalid(self.reason_number)
        if re.fullmatch(r"[ABKMHPCTX]{1,2}", entry.group("series")) is None:
            return PlateValidation.invalid(self.reason_series)
        return PlateValidation.valid()


class BulgariaServiceValidator(GatedPlateValidator):
    gate_group = "second"
    reason_code = "The code is BA (army) or CP (civil protection)."
    reason_digits = "BA takes 3 + 3 digits, CP 2 + 3."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        code = entry.group("code")
        if code not in ("BA", "CP"):
            return PlateValidation.invalid(self.reason_code)
        ok = (is_digits_of_length(entry.group("first"), 3 if code == "BA" else 2)
              and is_digits_of_length(entry.group("second"), 3))
        return PlateValidation.valid() if ok else PlateValidation.invalid(self.reason_digits)


class BulgariaStampedValidator(GatedPlateValidator):
    gate_group = "year"
    reason_prefix = "Foreigners are XX or XH; diplomats C, CC or CT."
    reason_digits = "Four digits (a diplomat's two mission digits, then two) and a two-digit year."

    def validate(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("mission") in _REFUSED:
            return PlateValidation.invalid(_NOT_FOUND)
        return super().validate(entry)

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("region") not in ("XX", "XH", "C", "CC", "CT"):
            return PlateValidation.invalid(self.reason_prefix)
        if any(g.key == "mission" for g in entry.spec.text_groups):
            digits = is_digits_of_length(entry.group("mission"), 2) and is_digits_of_length(entry.group("number"), 2)
        else:
            digits = is_digits_of_length(entry.group("number"), 4)
        if digits and is_digits_of_length(entry.group("year"), 2):
            return PlateValidation.valid()
        return PlateValidation.invalid(self.reason_digits)
