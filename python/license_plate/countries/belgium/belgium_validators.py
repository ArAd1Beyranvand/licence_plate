from __future__ import annotations

from plate_core import PlateEntry, PlateValidation, is_digits


class BelgiumValidator:
    reason_length = "A field has the wrong number of symbols."
    reason_kind = "A field mixes letters and digits."
    reason_dealer = "A dealer plate (first letter Z) has a second letter from A to Y."

    _rules_map: dict[str, list[tuple[str, bool, int, int]]] = {
        "be.private": [
            ("series", True, 1, 1),
            ("letters", False, 3, 3),
            ("serial", True, 3, 3),
        ],
        "be.plain": [
            ("series", True, 1, 1),
            ("letters", False, 3, 3),
            ("serial", True, 3, 3),
        ],
        "be.motorcycle": [
            ("series", False, 1, 1),
            ("letters", False, 3, 3),
            ("serial", True, 3, 3),
        ],
        "be.temporary": [
            ("kind", False, 2, 2),
            ("number", True, 2, 2),
            ("letters", False, 3, 3),
        ],
        "be.vintage": [
            ("series", True, 3, 3),
            ("serial", True, 3, 3),
        ],
        "be.diplomatic": [
            ("letters", False, 2, 2),
            ("serial", True, 3, 3),
        ],
        "be.royal": [("number", True, 1, 2)],
        "be.military": [("serial", True, 5, 5)],
    }

    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = None
        if refused is not None:
            return refused

        rules = self._rules_map.get(entry.spec.id, [])
        if all(entry.group(r[0]) == "" for r in rules):
            return PlateValidation.valid()

        for r in rules:
            key, digits, min_len, max_len = r
            v = entry.group(key)
            if len(v) < min_len or len(v) > max_len:
                return PlateValidation.invalid(self.reason_length)

            all_digits = is_digits(v)
            no_digits = not any(0x30 <= ord(u) <= 0x39 for u in v)
            if digits and not all_digits:
                return PlateValidation.invalid(self.reason_kind)
            if not digits and not no_digits:
                return PlateValidation.invalid(self.reason_kind)

        if entry.spec.id == "be.plain":
            l = entry.group("letters")
            if l.startswith("ZZ"):
                return PlateValidation.invalid(self.reason_dealer)

        return PlateValidation.valid()
