from __future__ import annotations

import re

from plate_core import PlateEntry, PlateValidation, restriction_verdict

_PROVINCES = frozenset("ADFMTU")
_DIPLOMATIC_SERIES = frozenset(("CD", "CMD", "CMC", "PE"))


class MadagascarValidator:
    provinces = _PROVINCES
    diplomatic_series = _DIPLOMATIC_SERIES
    REASON_NUMBER = "The number is one to five digits."
    REASON_SERIES = "The series is two or three letters."
    REASON_PROVINCE = "The first letter is the province: A, D, F, M, T or U."
    REASON_COUNTRY = "The country code is three digits."
    REASON_DIPLOMATIC = "The series is CD, CMD, CMC or PE."

    def validate(self, entry: PlateEntry) -> PlateValidation:
        broken = restriction_verdict(entry)
        if broken is not None:
            return broken
        number, series, country = entry.group("number"), entry.group("series"), entry.group("country")
        if number and not re.fullmatch("[0-9]{1,5}", number):
            return PlateValidation.invalid(self.REASON_NUMBER)
        if country:
            if not re.fullmatch("[0-9]{3}", country):
                return PlateValidation.invalid(self.REASON_COUNTRY)
            if series and series not in _DIPLOMATIC_SERIES:
                return PlateValidation.invalid(self.REASON_DIPLOMATIC)
        elif series:
            if not re.fullmatch("[A-Z]{1,3}", series):
                return PlateValidation.invalid(self.REASON_SERIES)
            province = series[-1] if series.startswith("WW") else series[0]
            if len(series) > 1 and province not in _PROVINCES:
                return PlateValidation.invalid(self.REASON_PROVINCE)
        return PlateValidation.valid()
