from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, PlateValidator, is_digits, is_digits_of_length, restriction_verdict)


_LEAD = re.compile(r"[1-9]")
_SERIAL = re.compile(r"[1-9][0-9]{0,3}")
_LETTERS = frozenset("กขคงจฉชฌฏฐณดตถทธนบปผพฟภมยรลวศษสหฬอฮญฒฆซ")


class ThailandValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_lead = "A leading digit is 1 to 9."
    reason_series = "The series is Thai consonants."
    reason_prefix = "The series is two digits."
    reason_serial = "The number is 1 to 9999."
    reason_truck_serial = "The number is four digits."
    reason_code = "The province code is two digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec = entry.spec
        lead = entry.group("lead")
        if spec.indices_of_group("lead") and lead and not _LEAD.fullmatch(lead):
            return PlateValidation.invalid(self.reason_lead)
        letters = len(spec.indices_of_group("series"))
        if letters > 0:
            series = entry.group("series")
            if len(series) != letters or not all(c in _LETTERS for c in series):
                return PlateValidation.invalid(self.reason_series)
        if spec.indices_of_group("prefix"):
            if not is_digits_of_length(entry.group("prefix"), 2):
                return PlateValidation.invalid(self.reason_prefix)
            if not is_digits_of_length(entry.group("serial"), 4):
                return PlateValidation.invalid(self.reason_truck_serial)
            code = entry.group("code")
            if code and not is_digits_of_length(code, 2):
                return PlateValidation.invalid(self.reason_code)
            return PlateValidation.valid()
        if not _SERIAL.fullmatch(entry.group("serial")):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()
