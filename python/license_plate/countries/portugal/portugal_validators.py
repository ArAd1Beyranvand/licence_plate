from __future__ import annotations

import re

from plate_core import (
    PlateEntry, PlateValidation, is_digits, is_digits_of_length, restriction_verdict)

_LETTERS = re.compile(r"[A-Z]{2}")
_LETTER = re.compile(r"[A-Z]")
_MIXED = re.compile(r"[A-Z][0-9]")
_INT = re.compile(r"[+-]?[0-9]+")

_REASON_SHAPE = "A plate is three fields of two characters: letters AA, digits 00."
_REASON_DATE = "The ribbon is a two-digit year and month."
_REASON_GNR = "A GNR plate is one letter and four digits."
_REASON_TRAILER = "A trailer plate is one or two district letters and up to six digits."
_REASON_DIPLOMATIC = "A diplomatic plate is one to three digits, CD and three digits."


def _pair(v: str) -> bool:
    return _LETTERS.fullmatch(v) is not None or is_digits_of_length(v, 2)


def _verdict(ok: bool, reason: str) -> PlateValidation:
    return PlateValidation.valid() if ok else PlateValidation.invalid(reason)


class PortugalValidator:
    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        g = entry.group

        embassy = g("embassy")
        if embassy:
            return _verdict(len(embassy) <= 3 and is_digits(embassy) and g("code") == "CD"
                            and is_digits_of_length(g("number"), 3), _REASON_DIPLOMATIC)
        district = g("district")
        if district:
            number = g("number")
            return _verdict(_LETTERS.fullmatch(district.ljust(2, "A")) is not None
                            and is_digits(number) and len(number) <= 6, _REASON_TRAILER)
        letter = g("letter")
        if letter:
            return _verdict(_LETTER.fullmatch(letter) is not None
                            and is_digits_of_length(g("number"), 4), _REASON_GNR)

        first = g("first")
        if not first:
            return PlateValidation.valid()
        if not (_pair(first) or _MIXED.fullmatch(first)) or not _pair(g("second")) or not _pair(g("third")):
            return PlateValidation.invalid(_REASON_SHAPE)
        year, month = g("year"), g("month")
        if year or month:
            m = int(month) if _INT.fullmatch(month) else None
            if (not is_digits_of_length(year, 2) or not is_digits_of_length(month, 2)
                    or m is None or m < 1 or m > 12):
                return PlateValidation.invalid(_REASON_DATE)
        return PlateValidation.valid()
