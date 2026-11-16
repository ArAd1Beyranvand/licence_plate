from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


@dataclass(frozen=True)
class BruneiValidator(GatedPlateValidator):
    gate_group = "number"
    military = "MOD"
    reason_prefix_missing = "A plate starts with letters."
    reason_series = "A plate starts with B or K, or is MOD."
    reason_lone_k = "There is no plate with the single letter K."
    reason_k_series = "A K series runs from KA to KP."
    reason_no_io = "I and O are not issued on Brunei plates."
    reason_number = "The number is 1 to 9999."
    reason_leading_zero = "The number has no leading zero."
    reason_suffix = "Only a MOD plate has a branch letter."
    _unissued = re.compile(r"[IO]")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return self.validate_fields(
            prefix=entry.group("prefix"),
            number=entry.group("number"),
            suffix=entry.group("suffix"),
        )

    @staticmethod
    def validate_fields(
        prefix: str,
        number: str,
        suffix: str = "",
    ) -> PlateValidation:
        if not prefix:
            return PlateValidation.invalid(BruneiValidator.reason_prefix_missing)

        mod = prefix == BruneiValidator.military
        if not mod:
            if prefix[0] not in ("B", "K"):
                return PlateValidation.invalid(BruneiValidator.reason_series)
            if BruneiValidator._unissued.search(prefix + suffix):
                return PlateValidation.invalid(BruneiValidator.reason_no_io)
            if prefix[0] == "K":
                if len(prefix) == 1:
                    return PlateValidation.invalid(BruneiValidator.reason_lone_k)
                if prefix[1] > "P":
                    return PlateValidation.invalid(BruneiValidator.reason_k_series)
            if suffix:
                return PlateValidation.invalid(BruneiValidator.reason_suffix)

        if not number or len(number) > 4 or not is_digits(number):
            return PlateValidation.invalid(BruneiValidator.reason_number)

        if number.startswith("0"):
            return PlateValidation.invalid(BruneiValidator.reason_leading_zero)

        return PlateValidation.valid()


@dataclass(frozen=True)
class BruneiDiplomaticValidator(GatedPlateValidator):
    gate_group = "mission"
    reason_digits = "Each number is one or two digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        for part in (entry.group("serial"), entry.group("mission")):
            if not part or len(part) > 2 or not is_digits(part):
                return PlateValidation.invalid(BruneiDiplomaticValidator.reason_digits)
        return PlateValidation.valid()
