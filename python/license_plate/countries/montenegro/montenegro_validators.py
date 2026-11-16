from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length

_LETTERS = "ABCDEFGHJKLMNPQRSTUVWXYZ"  # A-Z without I and O
_DIPLOMATIC_LETTERS = "ACEMP"
_MIXED = _LETTERS + "0123456789"
_MUNICIPALITIES = frozenset((
    "AN BA BD BP BR CT DG GS HN KL KO MK NK PG PL PT PŽ PV RO ŠN TV TZ UL ZT ŽB").split())


def _in(alphabet: str, value: str, n: int) -> bool:
    return len(value) == n and all(c in alphabet for c in value)


class MontenegroValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_region = "The municipal code is two letters, e.g. PG."
    reason_digits = "Check the number of digits."
    reason_letters = "Check the series letters."

    @staticmethod
    def _ok(ok: bool, reason: str) -> PlateValidation:
        return PlateValidation.valid() if ok else PlateValidation.invalid(reason)

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec_id = entry.spec.id
        serial = entry.group("serial")
        if spec_id == "me.diplomatic":
            code = entry.group("code")
            return self._ok(
                (is_digits_of_length(code, 2) or is_digits_of_length(code, 3))
                and _in(_DIPLOMATIC_LETTERS, entry.group("letter"), 1)
                and is_digits_of_length(serial, 3), self.reason_digits)
        if entry.group("region") not in _MUNICIPALITIES:
            return PlateValidation.invalid(self.reason_region)
        if spec_id == "me.regular":
            return self._ok(_in(_LETTERS, entry.group("letters"), 2) and is_digits_of_length(serial, 3),
                            self.reason_letters)
        if spec_id == "me.temporary":
            return self._ok(is_digits_of_length(entry.group("year"), 2) and is_digits_of_length(serial, 3),
                            self.reason_digits)
        if spec_id == "me.agricultural":
            return self._ok(_in(_LETTERS, entry.group("letters"), 2) and is_digits_of_length(serial, 2),
                            self.reason_letters)
        return self._ok(_in(_MIXED, serial, 4), self.reason_digits)
