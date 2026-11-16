from __future__ import annotations

import re

from plate_core import PlateEntry, PlateValidation, is_digits_of_length, restriction_verdict

_REGION_CODES = (
    "BJ", "BM", "ČK", "DA", "DE", "DJ", "DU", "GS", "IM", "KA", "KC", "KR",
    "KT", "KŽ", "MA", "NA", "NG", "OG", "OS", "PU", "PŽ", "RI", "SB", "SK",
    "SL", "ST", "ŠI", "VK", "VT", "VU", "VŽ", "ZD", "ZG", "ŽU",
)
_CLASS = re.compile(r"[A-Z]")
_WORD = re.compile(r"[A-Z]{4,5}")
_SUFFIX = re.compile(r"[0-9]{1,2}")
_NUMBER = re.compile(r"[0-9]{3,4}")
_LETTERS = re.compile(r"[A-Z]{1,2}")


class CroatiaValidator:
    REASON_REGION = "The city code is two letters, e.g. ZG."
    REASON_NUMBER = "The number is three or four digits."
    REASON_LETTERS = "The series is one or two letters."
    REASON_WORD = "The word is four to five letters."
    REASON_SUFFIX = "The suffix is one or two digits."
    REASON_POLICE = "Police is three digits, three digits."
    REASON_DIPLOMATIC = "Diplomatic is three digits, a letter, three digits."

    def validate(self, entry: PlateEntry) -> PlateValidation:
        broken = restriction_verdict(entry)
        if broken is not None:
            return broken
        groups = entry.spec.text_groups
        if not groups or not entry.group(groups[-1].key or ""):
            return PlateValidation.valid()
        reason = self._reason(entry)
        return PlateValidation.valid() if reason is None else PlateValidation.invalid(reason)

    @classmethod
    def _reason(cls, e: PlateEntry) -> str | None:
        first = e.spec.text_groups[0].key
        if first == "mission":
            ok = (is_digits_of_length(e.group("mission"), 3) and _CLASS.fullmatch(e.group("class"))
                  and is_digits_of_length(e.group("serial"), 3))
            return None if ok else cls.REASON_DIPLOMATIC
        if first == "first":
            ok = is_digits_of_length(e.group("first"), 3) and is_digits_of_length(e.group("second"), 3)
            return None if ok else cls.REASON_POLICE
        if e.group("region") not in _REGION_CODES:
            return cls.REASON_REGION
        if any(g.key == "word" for g in e.spec.text_groups):
            if not _WORD.fullmatch(e.group("word")):
                return cls.REASON_WORD
            return None if _SUFFIX.fullmatch(e.group("suffix")) else cls.REASON_SUFFIX
        if not _NUMBER.fullmatch(e.group("number")):
            return cls.REASON_NUMBER
        return None if _LETTERS.fullmatch(e.group("letters")) else cls.REASON_LETTERS
