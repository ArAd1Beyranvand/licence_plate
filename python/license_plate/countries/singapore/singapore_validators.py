from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


class SingaporeChecksum:
    letters = "AZYXUTSRPMLKJHGEDCB"
    _weights = (9, 4, 5, 4, 3, 2)

    @staticmethod
    def of(prefix: str, serial: str) -> str | None:
        if not prefix or len(prefix) > 3 or not SingaporeChecksum._is_letters(prefix):
            return None
        if not is_digits(serial) or len(serial) > 4:
            return None
        tail = prefix[-2:] if len(prefix) > 2 else prefix
        numbers = [0] if len(tail) == 1 else [ord(u) - 0x40 for u in tail]
        numbers.extend(ord(u) - 0x30 for u in serial.zfill(4))
        sum_val = sum(n * w for n, w in zip(numbers, SingaporeChecksum._weights))
        return SingaporeChecksum.letters[sum_val % 19]

    @staticmethod
    def _is_letters(s: str) -> bool:
        return all(0x41 <= ord(u) <= 0x5A for u in s)


class SingaporeValidator(GatedPlateValidator):
    gate_group = "serial"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return self.validate_fields(
            prefix=entry.group("prefix"),
            serial=entry.group("serial"),
            check=entry.group("check"),
        )

    @staticmethod
    def validate_fields(prefix: str, serial: str, check: str) -> PlateValidation:
        if SingaporeChecksum.of(prefix, "0") is None:
            return PlateValidation.invalid("The prefix is one to three letters.")
        if not is_digits(serial) or len(serial) > 4 or serial.startswith("0"):
            return PlateValidation.invalid("The number is one to four digits, without leading zeros.")
        if check and check != SingaporeChecksum.of(prefix, serial):
            return PlateValidation.invalid("The checksum letter does not match the number.")
        return PlateValidation.valid()
