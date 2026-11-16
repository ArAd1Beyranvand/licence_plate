from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import LATIN_UPPERCASE
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length

REASON_CAR = 'A plate is an office, a class code, a hiragana and a four-place serial.'
REASON_CLASS = 'A class code is two digits, then a digit or a letter.'
REASON_SERIAL = 'A serial is four places; leading zeros are printed as dots.'
REASON_EXPORT = 'An export plate is two or three letters, one or two letters and four digits.'
REASON_DIPLOMATIC = 'A diplomatic plate is five digits.'

_CLASS = re.compile(r'[0-9]{2}[0-9A-Z]?')
_OFFICE_LATIN = re.compile(r'[A-Z]{2,3}')
_KANA_LATIN = re.compile(r'[A-Z]{1,2}')
_SERIAL = re.compile(r'(・・|・[0-9]|[0-9]{2})[0-9]{2}')


@dataclass(frozen=True)
class JapanValidator(GatedPlateValidator):
    gate_group = 'serial'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        serial, office, kana = entry.group('serial'), entry.group('office'), entry.group('kana')
        if not office:
            return PlateValidation.valid() if is_digits_of_length(serial, 5) else PlateValidation.invalid(REASON_DIPLOMATIC)
        if LATIN_UPPERCASE.accepts(office[0]):
            ok = (_OFFICE_LATIN.fullmatch(office) and _KANA_LATIN.fullmatch(kana)
                  and is_digits_of_length(serial, 4))
            return PlateValidation.valid() if ok else PlateValidation.invalid(REASON_EXPORT)
        if not kana:
            return PlateValidation.invalid(REASON_CAR)
        if entry.spec.indices_of_group('class') and not _CLASS.fullmatch(entry.group('class')):
            return PlateValidation.invalid(REASON_CLASS)
        return PlateValidation.valid() if _SERIAL.fullmatch(serial) else PlateValidation.invalid(REASON_SERIAL)
