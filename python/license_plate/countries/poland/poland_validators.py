from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import (
    PlateEntry, PlateValidation, is_digits, is_digits_of_length, restriction_verdict)

from .poland_missions import MISSIONS

REASON_CODE = 'Two or three letters.'
REASON_SERIES_LETTERS = 'B, D, I, O and Z are not used in a series.'
REASON_CAR_SERIES = 'Five characters, the first a digit after a two-letter code.'
REASON_THREE_LETTER_SERIES = ('Four characters after a three-letter code may not be digits only, '
                              'or three digits and a letter.')
REASON_VOIVODESHIP = 'A letter then a digit.'
REASON_CUSTOM = 'Three to five characters: a letter first, letters before digits, at most two digits.'
REASON_PROFESSIONAL = 'A letter and two digits, then two digits, P and two digits.'
REASON_TEMPORARY = 'Four digits, or three and a letter.'
REASON_TEST = 'Three digits, then the letter B.'
REASON_CLASSIC = 'Two or three letters and two or three characters, five in all.'
REASON_MOTORCYCLE = 'Two or three letters, then four.'
REASON_REDUCED = 'A letter, then three characters.'
REASON_DIPLOMATIC_LETTER = 'W is the only code issued.'
REASON_MISSION = 'Not a listed mission code.'
REASON_DIPLOMATIC_SERIAL = 'Three digits.'

_EXCLUDED = 'BDIOZ'
_LETTERS = frozenset('ABCDEFGHIJKLMNOPRSTUVWXYZ')
_DIGIT_THEN_LETTER = re.compile(r'[0-9][A-Z]')
_CUSTOM_SHAPE = re.compile(r'[A-Z]+[0-9]{0,2}')


def _is_letter(c: str) -> bool:
    return c in _LETTERS


def _all_letters(s: str) -> bool:
    return all(map(_is_letter, s))


def _voivodeship_digit(code: str) -> bool:
    return len(code) == 2 and _is_letter(code[0]) and is_digits(code[1])


def _car(code: str, serial: str) -> str | None:
    if not (len(code) >= 2 and _all_letters(code)):
        return REASON_CODE
    if any(c in _EXCLUDED for c in serial):
        return REASON_SERIES_LETTERS
    if len(code) == 2:
        return None if len(serial) == 5 and is_digits(serial[0]) else REASON_CAR_SERIES
    if len(serial) == 5:
        return None
    if len(serial) != 4:
        return REASON_CAR_SERIES
    digits_then_letter = is_digits(serial[:3]) and _is_letter(serial[3])
    return REASON_THREE_LETTER_SERIES if is_digits(serial) or digits_then_letter else None


def _custom(code: str, serial: str) -> str | None:
    if not _voivodeship_digit(code):
        return REASON_VOIVODESHIP
    shape = (len(serial) >= 3 and _is_letter(serial[0]) and not _DIGIT_THEN_LETTER.search(serial)
             and _CUSTOM_SHAPE.fullmatch(serial))
    return None if shape else REASON_CUSTOM


def _judge(entry: PlateEntry) -> str | None:
    g = entry.group
    code, serial = g('code'), g('serial')
    spec_id = entry.spec.id
    if spec_id == 'pl.diplomatic':
        w, m = g('voivodeship'), g('mission')
        if w and w != 'W':
            return REASON_DIPLOMATIC_LETTER
        if len(m) == 3 and m not in MISSIONS:
            return REASON_MISSION
        if serial and not is_digits(serial):
            return REASON_DIPLOMATIC_SERIAL
        return None
    if spec_id == 'pl.test':
        n, s = g('number'), g('suffix')
        if not code or not n or not s:
            return None
        if not _voivodeship_digit(code):
            return REASON_VOIVODESHIP
        return REASON_TEST if not is_digits_of_length(n, 3) or s != 'B' else None
    if not code or not serial:
        return None
    if spec_id == 'pl.private':
        return _car(code, serial)
    if spec_id == 'pl.custom':
        return _custom(code, serial)
    if spec_id == 'pl.professional':
        ok = (len(code) == 3 and _is_letter(code[0]) and is_digits(code[1:]) and len(serial) == 5
              and is_digits(serial[:2]) and serial[2] == 'P' and is_digits(serial[3:]))
        return None if ok else REASON_PROFESSIONAL
    if spec_id == 'pl.temporary':
        if not _voivodeship_digit(code):
            return REASON_VOIVODESHIP
        ok = len(serial) == 4 and is_digits(serial[:3]) and (is_digits(serial[3]) or _is_letter(serial[3]))
        return None if ok else REASON_TEMPORARY
    if spec_id == 'pl.classic':
        return None if len(code) + len(serial) == 5 and _all_letters(code) else REASON_CLASSIC
    if spec_id == 'pl.motorcycle':
        return None if len(code) >= 2 and _all_letters(code) and len(serial) == 4 else REASON_MOTORCYCLE
    if spec_id == 'pl.reduced':
        return None if _is_letter(code) and len(serial) == 3 else REASON_REDUCED
    return None


@dataclass(frozen=True)
class PolandValidator:
    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        bad = _judge(entry)
        return PlateValidation.valid() if bad is None else PlateValidation.invalid(bad)
