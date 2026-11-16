from __future__ import annotations

from plate_core import PlateEntry, PlateValidation, is_digits


class LuxembourgValidator:
    reason_length = 'A field has the wrong number of symbols.'
    reason_kind = 'A field mixes letters and digits.'

    _rules: dict[str, list[tuple[str, bool, int, int]]] = {
        'lu.standard': [
            ('letters', False, 2, 2),
            ('serial', True, 4, 4),
        ],
        'lu.diplomatic': [
            ('series', True, 2, 2),
            ('serial', True, 2, 2),
        ],
        'lu.military': [
            ('serial', True, 4, 4),
        ],
    }

    def validate(self, entry: PlateEntry) -> PlateValidation:
        # Placeholder for restriction logic if any; currently returns None.
        refused = None
        if refused is not None:
            return refused

        rules = self._rules.get(entry.spec.id, [])
        if all(entry.group(r[0]) == '' for r in rules):
            return PlateValidation.valid()

        for r in rules:
            key, digits, min_len, max_len = r
            v = entry.group(key)
            if len(v) < min_len or len(v) > max_len:
                return PlateValidation.invalid(self.reason_length)

            has_digit = any(0x30 <= ord(c) <= 0x39 for c in v)
            if digits and not is_digits(v):
                return PlateValidation.invalid(self.reason_kind)
            if not digits and has_digit:
                return PlateValidation.invalid(self.reason_kind)

        return PlateValidation.valid()
