from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation

_letter = re.compile(r'[A-Z]')
_two = re.compile(r'[A-Z]{2}')
_three = re.compile(r'[A-Z]{3}')
_pairs = {'a': _two, 'b': re.compile(r'[0-9]{2}'), 'c': re.compile(r'[0-9]{2}')}
_letter_digits_year = {'a': _letter, 'b': re.compile(r'[0-9]{5}'), 'c': re.compile(r'[0-9]{2}')}
_FORMATS = {
    'hu.private': {'a': _two, 'b': _two, 'c': re.compile(r'[0-9]{3}')},
    'hu.diplomatic': _pairs,
    'hu.staff': _pairs,
    'hu.agricultural': {'a': _letter, 'b': re.compile(r'[0-9]{6}')},
    'hu.export': _letter_digits_year,
    'hu.trial': _letter_digits_year,
    'hu.slow': {'a': _three, 'b': re.compile(r'[0-9]{3}')},
}


class HungaryValidator(GatedPlateValidator):
    gate_group = 'a'

    REASON = 'The plate does not match its format.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        fmt = _FORMATS.get(entry.spec.id)
        if fmt is not None:
            for key, rx in fmt.items():
                if not rx.fullmatch(entry.group(key)):
                    return PlateValidation.invalid(self.REASON)
        return PlateValidation.valid()
