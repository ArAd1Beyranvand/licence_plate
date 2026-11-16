from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length


@dataclass(frozen=True)
class FranceValidator(GatedPlateValidator):
    temporary: bool
    gate_group = "number"

    reason_prefix = "The prefix is two letters (no I, O, U or SS)."
    reason_temporary = "A temporary plate starts WW."
    reason_number = "The number is three digits, 001–999."
    reason_suffix = "The suffix is two letters (no I, O, U or SS)."
    reason_department = "The département is two digits (01–95), 2A or 2B."
    reason_month = "The month is 01–12."
    reason_year = "The year is two digits."

    _letters = re.compile(r"^[A-HJ-NP-TV-Z]{2}$")
    _department = re.compile(r"^(0[1-9]|1[0-9]|2[0-9]|[3-8][0-9]|9[0-5]|2A|2B)$")
    _month = re.compile(r"^(0[1-9]|1[0-2])$")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        prefix = entry.group("prefix")
        if not self._letters.fullmatch(prefix) or prefix == "SS":
            return PlateValidation.invalid(self.reason_prefix)
        if self.temporary != (prefix == "WW"):
            return PlateValidation.invalid(self.reason_temporary)
        number = entry.group("number")
        if not is_digits_of_length(number, 3) or number == "000":
            return PlateValidation.invalid(self.reason_number)
        suffix = entry.group("suffix")
        if not self._letters.fullmatch(suffix) or suffix == "SS":
            return PlateValidation.invalid(self.reason_suffix)
        department = entry.group("department")
        if department and not self._department.fullmatch(department):
            return PlateValidation.invalid(self.reason_department)
        month = entry.group("month")
        if month and not self._month.fullmatch(month):
            return PlateValidation.invalid(self.reason_month)
        year = entry.group("year")
        if year and not is_digits_of_length(year, 2):
            return PlateValidation.invalid(self.reason_year)
        return PlateValidation.valid()


class FranceDiplomaticValidator(GatedPlateValidator):
    gate_group = "embassy"

    reason_embassy = "The embassy code is one to three digits."
    reason_status = "The status is C, CD, CMD or K."
    reason_series = "The series is one to three digits."

    statuses = ["C", "CD", "CMD", "K"]

    def judge(self, entry: PlateEntry) -> PlateValidation:
        embassy = entry.group("embassy")
        if not is_digits(embassy) or len(embassy) > 3:
            return PlateValidation.invalid(self.reason_embassy)
        if entry.group("status") not in self.statuses:
            return PlateValidation.invalid(self.reason_status)
        series = entry.group("series")
        if not is_digits(series) or len(series) > 3:
            return PlateValidation.invalid(self.reason_series)
        return PlateValidation.valid()
