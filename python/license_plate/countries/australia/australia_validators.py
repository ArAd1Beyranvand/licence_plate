from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation

_LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
_DIGITS = "0123456789"

# Shape characters: a letter, n digit, z digit 1-9, x letter but I/O, m letter or digit, else literal.
_FORMATS: dict[str, tuple[tuple[str, int | None], ...]] = {
    "au.nsw": (("aa", None), ("nn", None), ("xa", None)),
    "au.nt": (("Ca", None), ("nn", None), ("aa", None)),
    "au.federalInterstate": (("aa", None), ("nn", None), ("aa", None)),
    "au.act": (("Yaa", None), ("nna", None)),
    "au.qld": (("nnn", None), ("mmm", None)),
    "au.sa": (("Snnn", None), ("aaa", None)),
    "au.tas": (("a", None), ("nn", None), ("aa", None)),
    "au.vic": (("zaa", None), ("zaa", None)),
    "au.wa": (("zaaa", None), ("nnn", None)),
    "au.nationalHeavyVehicle": (("aa", None), ("nnaa", None)),
    "au.army": (("nn", None), ("nnnn", 3)),
    "au.airForce": (("nnnnnn", None),),
    "au.defence": (("a", None), ("mmmmm", None)),
    "au.diplomatic": (("Da", None), ("nnnnn", 4)),
}


def _matches(s: str, c: str) -> bool:
    if s == "a":
        return c in _LETTERS
    if s == "x":
        return c in _LETTERS and c not in "IO"
    if s == "n":
        return c in _DIGITS
    if s == "z":
        return c in _DIGITS and c != "0"
    if s == "m":
        return c in _LETTERS or c in _DIGITS
    return c == s


def _accepts(shape: str, minimum: int | None, value: str) -> bool:
    if len(value) < (len(shape) if minimum is None else minimum) or len(value) > len(shape):
        return False
    return all(_matches(shape[i], c) for i, c in enumerate(value))


class AustraliaValidator(GatedPlateValidator):
    gate_group = "f0"
    reason_field = "A field does not fit this plate's format."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        fields = _FORMATS.get(entry.spec.id)
        if fields is None:
            return PlateValidation.valid()
        for i, (shape, minimum) in enumerate(fields):
            if not _accepts(shape, minimum, entry.group(f"f{i}")):
                return PlateValidation.invalid(self.reason_field)
        return PlateValidation.valid()
