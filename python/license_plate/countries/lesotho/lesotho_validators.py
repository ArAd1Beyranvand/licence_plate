
from plate_core import PlateCheck, RuledPlateValidator


class LesothoValidator(RuledPlateValidator):
    checks = (
        PlateCheck("letters", r"[A-Z]{1,2}", "The prefix is one or two letters."),
        PlateCheck("serial", r"[0-9]{4}", "The number is four digits."),
    )
