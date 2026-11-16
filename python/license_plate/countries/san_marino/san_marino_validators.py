
from plate_core import PlateCheck, RuledPlateValidator


class SanMarinoValidator(RuledPlateValidator):
    checks = (
        PlateCheck("prefix", r"[A-Z]{1,7}", "The prefix is one to seven letters."),
        PlateCheck("number", r"[0-9]{1,4}", "The number is one to four digits."),
    )
