from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


def _formats(spec: dict[str, dict[str, str]]) -> dict[str, dict[str, re.Pattern[str]]]:
    return {k: {g: re.compile(p) for g, p in v.items()} for k, v in spec.items()}


_CURRENT = {'a': r'[0-9][ABCEHJKLMPSTUZ][A-Z0-9]|EL[0-9]', 'b': r'[A-Z0-9]{4}'}
_DIGIT_PAIRS = {'b': r'[0-9]{2}', 'c': r'[0-9]{2}'}
_FORMATS = _formats({
    'cz.private': _CURRENT,
    'cz.private2001': _CURRENT,
    'cz.usSize': _CURRENT,
    'cz.motorcycle': {'a': r'[A-Z0-9]{2}', 'b': r'[0-9]{4}'},
    'cz.personalised': {'a': r'[A-Z0-9]{1,3}', 'b': r'[A-Z0-9]{1,5}'},
    'cz.classic': {'a': r'[A-Z]{2,3}', **_DIGIT_PAIRS},
    'cz.classic70s': {'a': r'[A-Z]{2}', **_DIGIT_PAIRS},
    'cz.military': {'a': r'[0-9]{3}', **_DIGIT_PAIRS},
    'cz.export': {'a': r'[A-Z0-9]{3}', 'b': r'[A-Z0-9]{3}'},
    'cz.diplomatic': {'a': r'[0-9]{3}', 'b': r'[A-Z]{2}', 'c': r'[0-9]{2}'},
    'cz.veteran': {'a': r'V', 'b': r'[0-9]{4}'},
})


class CzechRepublicValidator(GatedPlateValidator):
    gate_group = 'b'

    REASON = 'The plate does not match its format.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        fmt = _FORMATS.get(entry.spec.id)
        if fmt is not None:
            for key, rx in fmt.items():
                if not rx.fullmatch(entry.group(key)):
                    return PlateValidation.invalid(self.REASON)
        return PlateValidation.valid()
