from __future__ import annotations

from plate_core import PlateTheme

_INACTIVE = 0xFFB0B0B0
_BLACK = 0xFF000000


def _theme(field, ink):
    return PlateTheme.monochrome(field, ink, _INACTIVE, 0.036, 0.08)


class LatviaThemes:
    private = _theme(0xFFFFFFFF, _BLACK)
    taxi = _theme(0xFFFFCA0D, _BLACK)
    electric = _theme(0xFFFBFEFE, 0xFF0995D0)
    diplomatic = _theme(0xFFD60000, _BLACK)
    motorcycle = private

    @staticmethod
    def by_letters(base, group):
        letters = group("letters")
        if letters in ("TX", "TQ"):
            return LatviaThemes.taxi
        return LatviaThemes.electric if letters == "EX" else base
