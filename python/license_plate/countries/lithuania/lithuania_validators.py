from __future__ import annotations

from plate_core import (
    PlateEntry, PlateValidation, is_digits, is_digits_of_length, restriction_verdict)

_LETTERS = frozenset("ABCDEFGHIJKLMNOPRSTUVYZ")
_MISSIONS = frozenset(
    "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 18 19 20 21 22 23 24 25 26 28 29 30 31 32 33 34 36 37 39 40 42 43".split())

_REASON_LETTERS = "Letters exclude Q, W and X."
_REASON_REGULAR = "Three letters then three digits."
_REASON_TAXI = "T then five digits."
_REASON_DEALER = "P then five digits."
_REASON_TEMPORARY = "Four digits then one or two letters."
_REASON_MILITARY = "LK, three digits, then a letter."
_REASON_AGRICULTURAL = "A letter, three or four digits, then a letter."
_REASON_MISSION = "Not a listed mission code."
_REASON_STATUS = "The status digit is 1 to 4."
_REASON_SERIAL = "Two or three digits."


def _letters(value: str) -> bool:
    return all(c in _LETTERS for c in value)


def _prefixed(prefix: str, number: str, expected: str, reason: str) -> str | None:
    if not prefix or not number:
        return None
    return None if prefix == expected and is_digits_of_length(number, 5) else reason


class LithuaniaValidator:
    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        g = entry.group
        bad = None
        sid = entry.spec.id
        if sid == "lt.private":
            l, n = g("letters"), g("number")
            if l and n:
                if not _letters(l):
                    bad = _REASON_LETTERS
                elif not (len(l) == 3 and is_digits_of_length(n, 3)):
                    bad = _REASON_REGULAR
        elif sid == "lt.taxi":
            bad = _prefixed(g("prefix"), g("number"), "T", _REASON_TAXI)
        elif sid == "lt.dealer":
            bad = _prefixed(g("prefix"), g("number"), "P", _REASON_DEALER)
        elif sid == "lt.temporary":
            n, l = g("number"), g("letters")
            if n and l:
                if not _letters(l):
                    bad = _REASON_LETTERS
                elif not (is_digits_of_length(n, 4) and len(l) <= 2):
                    bad = _REASON_TEMPORARY
        elif sid == "lt.military":
            c, n, l = g("code"), g("number"), g("letters")
            if c and n and l and (c != "LK" or not is_digits_of_length(n, 3) or not _letters(l)):
                bad = _REASON_MILITARY
        elif sid == "lt.agricultural":
            p, n, s = g("prefix"), g("number"), g("suffix")
            if p and n and s:
                if not _letters(p + s):
                    bad = _REASON_LETTERS
                elif not is_digits(n) or len(n) < 3:
                    bad = _REASON_AGRICULTURAL
        elif sid == "lt.diplomatic":
            m, s, n = g("mission"), g("status"), g("serial")
            if len(m) == 2 and m not in _MISSIONS:
                bad = _REASON_MISSION
            elif s and s not in "1234":
                bad = _REASON_STATUS
            elif n and not (is_digits(n) and len(n) >= 2):
                bad = _REASON_SERIAL
        return PlateValidation.valid() if bad is None else PlateValidation.invalid(bad)
